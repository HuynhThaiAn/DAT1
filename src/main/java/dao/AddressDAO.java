package dao;

import model.Address;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {

    // ===== LIST (active only, default first) =====
    public List<Address> getByCustomerId(int customerId) throws Exception {
        List<Address> list = new ArrayList<>();

        String sql =
            "SELECT AddressID, CustomerID, RecipientName, Phone, " +
            "       Province, District, Ward, DetailAddress, " +
            "       IsDefault, IsActive, CreatedAt, UpdatedAt " +
            "FROM Address " +
            "WHERE CustomerID = ? AND IsActive = 1 " +
            "ORDER BY IsDefault DESC, AddressID DESC";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Address a = map(rs);
                    list.add(a);
                }
            }
            return list;

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    // ===== GET BY ID =====
    public Address getById(int addressId) throws Exception {
        String sql =
            "SELECT AddressID, CustomerID, RecipientName, Phone, " +
            "       Province, District, Ward, DetailAddress, " +
            "       IsDefault, IsActive, CreatedAt, UpdatedAt " +
            "FROM Address " +
            "WHERE AddressID = ?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, addressId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return map(rs);
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    // ===== GET DEFAULT (active only) =====
    public Address getDefaultAddressByCustomerId(int customerId) throws Exception {
        String sql =
            "SELECT TOP 1 AddressID, CustomerID, RecipientName, Phone, Province, District, Ward, DetailAddress, " +
            "       IsDefault, IsActive, CreatedAt, UpdatedAt " +
            "FROM Address " +
            "WHERE CustomerID=? AND IsActive=1 AND IsDefault=1 " +
            "ORDER BY AddressID DESC";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return map(rs);
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    // ===== INSERT (return new id) =====
    public int insert(Address a) throws Exception {
        String sql =
            "INSERT INTO Address (CustomerID, RecipientName, Phone, Province, District, Ward, DetailAddress, IsDefault, IsActive, CreatedAt, UpdatedAt) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1, SYSDATETIME(), SYSDATETIME()); " +
            "SELECT SCOPE_IDENTITY() AS NewAddressID;";

        DBContext db = new DBContext();
        Connection con = db.conn;

        try {
            con.setAutoCommit(false);

            // auto default nếu chưa có default
            boolean wantDefault = (a.getIsDefault() != null && a.getIsDefault());
            if (!wantDefault) {
                boolean hasDefault = hasAnyDefault(con, a.getCustomerID());
                if (!hasDefault) wantDefault = true;
            }

            // nếu muốn default -> clear default trước
            if (wantDefault) {
                clearDefault(con, a.getCustomerID());
            }

            int newId;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, a.getCustomerID());
                ps.setString(2, a.getRecipientName());
                ps.setString(3, a.getPhone());
                ps.setString(4, a.getProvince());
                ps.setString(5, a.getDistrict());
                ps.setString(6, a.getWard());
                ps.setString(7, a.getDetailAddress());
                ps.setBoolean(8, wantDefault);

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) throw new Exception("Cannot get NewAddressID");
                    newId = rs.getInt("NewAddressID");
                }
            }

            con.commit();
            return newId;

        } catch (Exception ex) {
            try { con.rollback(); } catch (Exception ignore) {}
            throw ex;

        } finally {
            try { con.setAutoCommit(true); } catch (Exception ignore) {}
            if (con != null) con.close();
        }
    }

    // ===== UPDATE (ownership required) =====
    public boolean update(Address a) throws Exception {
        String sql =
            "UPDATE Address " +
            "SET RecipientName=?, Phone=?, Province=?, District=?, Ward=?, DetailAddress=?, IsDefault=?, UpdatedAt=SYSDATETIME() " +
            "WHERE AddressID=? AND CustomerID=? AND IsActive=1";

        DBContext db = new DBContext();
        Connection con = db.conn;

        try {
            con.setAutoCommit(false);

            boolean wantDefault = (a.getIsDefault() != null && a.getIsDefault());
            if (wantDefault) {
                clearDefault(con, a.getCustomerID());
            } else {
                // nếu bỏ tick default mà address này đang là default -> giữ default cũ (không cho mất default)
                // => check current isDefault trong DB
                boolean isCurrentlyDefault = isAddressCurrentlyDefault(con, a.getAddressID(), a.getCustomerID());
                if (isCurrentlyDefault) {
                    wantDefault = true;
                } else {
                    // nếu customer chưa có default -> auto set default cho address này
                    boolean hasDefault = hasAnyDefault(con, a.getCustomerID());
                    if (!hasDefault) wantDefault = true;
                }
            }

            int affected;
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, a.getRecipientName());
                ps.setString(2, a.getPhone());
                ps.setString(3, a.getProvince());
                ps.setString(4, a.getDistrict());
                ps.setString(5, a.getWard());
                ps.setString(6, a.getDetailAddress());
                ps.setBoolean(7, wantDefault);
                ps.setInt(8, a.getAddressID());
                ps.setInt(9, a.getCustomerID());

                affected = ps.executeUpdate();
            }

            con.commit();
            return affected > 0;

        } catch (Exception ex) {
            try { con.rollback(); } catch (Exception ignore) {}
            throw ex;

        } finally {
            try { con.setAutoCommit(true); } catch (Exception ignore) {}
            if (con != null) con.close();
        }
    }

    // ===== SOFT DELETE (IsActive=0) =====
    public boolean softDelete(int addressId, int customerId) throws Exception {
        String checkSql = "SELECT IsDefault FROM Address WHERE AddressID=? AND CustomerID=? AND IsActive=1";
        String deleteSql = "UPDATE Address SET IsActive=0, IsDefault=0, UpdatedAt=SYSDATETIME() WHERE AddressID=? AND CustomerID=? AND IsActive=1";

        DBContext db = new DBContext();
        Connection con = db.conn;

        try {
            con.setAutoCommit(false);

            boolean wasDefault = false;
            try (PreparedStatement ps = con.prepareStatement(checkSql)) {
                ps.setInt(1, addressId);
                ps.setInt(2, customerId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        con.commit();
                        return false;
                    }
                    wasDefault = rs.getBoolean("IsDefault");
                }
            }

            int affected;
            try (PreparedStatement ps = con.prepareStatement(deleteSql)) {
                ps.setInt(1, addressId);
                ps.setInt(2, customerId);
                affected = ps.executeUpdate();
            }

            // nếu xóa default -> set default address active mới nhất
            if (affected > 0 && wasDefault) {
                int newestId = getNewestActiveAddressId(con, customerId);
                if (newestId > 0) {
                    clearDefault(con, customerId);
                    setDefault(con, newestId, customerId);
                }
            }

            con.commit();
            return affected > 0;

        } catch (Exception ex) {
            try { con.rollback(); } catch (Exception ignore) {}
            throw ex;

        } finally {
            try { con.setAutoCommit(true); } catch (Exception ignore) {}
            if (con != null) con.close();
        }
    }

    // ===== SET DEFAULT (clear + set) =====
    public boolean setDefaultAddress(int addressId, int customerId) throws Exception {
        DBContext db = new DBContext();
        Connection con = db.conn;

        try {
            con.setAutoCommit(false);

            clearDefault(con, customerId);
            boolean ok = setDefault(con, addressId, customerId);

            con.commit();
            return ok;

        } catch (Exception ex) {
            try { con.rollback(); } catch (Exception ignore) {}
            throw ex;

        } finally {
            try { con.setAutoCommit(true); } catch (Exception ignore) {}
            if (con != null) con.close();
        }
    }

    // ================== PRIVATE HELPERS (same Connection) ==================

    private Address map(ResultSet rs) throws Exception {
        Address a = new Address();
        a.setAddressID(rs.getInt("AddressID"));
        a.setCustomerID(rs.getInt("CustomerID"));
        a.setRecipientName(rs.getString("RecipientName"));
        a.setPhone(rs.getString("Phone"));
        a.setProvince(rs.getString("Province"));
        a.setDistrict(rs.getString("District"));
        a.setWard(rs.getString("Ward"));
        a.setDetailAddress(rs.getString("DetailAddress"));
        a.setIsDefault(rs.getBoolean("IsDefault"));
        a.setIsActive(rs.getBoolean("IsActive"));

        Timestamp created = rs.getTimestamp("CreatedAt");
        a.setCreatedAt(created == null ? null : created.toLocalDateTime());

        Timestamp updated = rs.getTimestamp("UpdatedAt");
        a.setUpdatedAt(updated == null ? null : updated.toLocalDateTime());

        return a;
    }

    private boolean hasAnyDefault(Connection con, int customerId) throws Exception {
        String sql = "SELECT 1 FROM Address WHERE CustomerID=? AND IsActive=1 AND IsDefault=1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private void clearDefault(Connection con, int customerId) throws Exception {
        String sql = "UPDATE Address SET IsDefault=0, UpdatedAt=SYSDATETIME() WHERE CustomerID=? AND IsActive=1 AND IsDefault=1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.executeUpdate();
        }
    }

    private boolean setDefault(Connection con, int addressId, int customerId) throws Exception {
        String sql = "UPDATE Address SET IsDefault=1, UpdatedAt=SYSDATETIME() WHERE AddressID=? AND CustomerID=? AND IsActive=1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            ps.setInt(2, customerId);
            return ps.executeUpdate() > 0;
        }
    }

    private int getNewestActiveAddressId(Connection con, int customerId) throws Exception {
        String sql = "SELECT TOP 1 AddressID FROM Address WHERE CustomerID=? AND IsActive=1 ORDER BY AddressID DESC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("AddressID");
            }
        }
        return 0;
    }

    private boolean isAddressCurrentlyDefault(Connection con, int addressId, int customerId) throws Exception {
        String sql = "SELECT IsDefault FROM Address WHERE AddressID=? AND CustomerID=? AND IsActive=1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            ps.setInt(2, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return false;
                return rs.getBoolean("IsDefault");
            }
        }
    }
}
