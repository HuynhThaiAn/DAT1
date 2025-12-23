package dao;

import model.Customer;
import utils.DBContext;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

public class CustomerDAO {

    public boolean existsByEmail(String email) throws Exception {
        String sql = "SELECT 1 FROM Customer WHERE Email = ?";
        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public Customer login(String email, String passwordHash) throws Exception {
        String sql = "SELECT CustomerID, Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, AvatarUrl, IsBlocked, CreatedAt, UpdatedAt "
                + "FROM Customer "
                + "WHERE Email = ? AND PasswordHash = ? AND IsBlocked = 0";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, passwordHash);

            try ( ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setEmail(rs.getString("Email"));
                c.setPasswordHash(rs.getString("PasswordHash"));
                c.setFullName(rs.getString("FullName"));
                c.setPhone(rs.getString("Phone"));

                Date dob = rs.getDate("DateOfBirth");
                if (dob != null) {
                    c.setDateOfBirth(dob.toLocalDate());
                }

                int gender = rs.getInt("Gender");
                if (!rs.wasNull()) {
                    c.setGender(gender);
                } else {
                    c.setGender(null);
                }

                c.setAvatarUrl(rs.getString("AvatarUrl"));
                c.setIsBlocked(rs.getBoolean("IsBlocked"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) {
                    c.setCreatedAt(created.toLocalDateTime());
                }

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) {
                    c.setUpdatedAt(updated.toLocalDateTime());
                }

                return c;
            }
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public int insertAndGetId(Customer c) throws Exception {
        String sql = "INSERT INTO Customer(Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, AvatarUrl, IsBlocked) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, 0)";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getEmail());
            ps.setString(2, c.getPasswordHash());
            ps.setString(3, c.getFullName());
            ps.setString(4, c.getPhone());

            if (c.getDateOfBirth() != null) {
                ps.setDate(5, Date.valueOf(c.getDateOfBirth()));
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }

            if (c.getGender() != null) {
                ps.setInt(6, c.getGender());
            } else {
                ps.setNull(6, java.sql.Types.TINYINT);
            }

            ps.setString(7, c.getAvatarUrl());

            ps.executeUpdate();

            try ( ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
            return 0;

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public Customer getById(int id) throws Exception {
        String sql = "SELECT CustomerID, Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, AvatarUrl, IsBlocked, CreatedAt, UpdatedAt "
                + "FROM Customer WHERE CustomerID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try ( ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setEmail(rs.getString("Email"));
                c.setPasswordHash(rs.getString("PasswordHash"));
                c.setFullName(rs.getString("FullName"));
                c.setPhone(rs.getString("Phone"));

                Date dob = rs.getDate("DateOfBirth");
                if (dob != null) {
                    c.setDateOfBirth(dob.toLocalDate());
                }

                int gender = rs.getInt("Gender");
                if (!rs.wasNull()) {
                    c.setGender(gender);
                } else {
                    c.setGender(null);
                }

                c.setAvatarUrl(rs.getString("AvatarUrl"));
                c.setIsBlocked(rs.getBoolean("IsBlocked"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) {
                    c.setCreatedAt(created.toLocalDateTime());
                }

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) {
                    c.setUpdatedAt(updated.toLocalDateTime());
                }

                return c;
            }

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public boolean updateProfile(int customerId, String fullName, String phone,
            java.time.LocalDate dateOfBirth, Integer gender) throws Exception {
        String sql = "UPDATE Customer "
                + "SET FullName = ?, Phone = ?, DateOfBirth = ?, Gender = ?, UpdatedAt = SYSDATETIME() "
                + "WHERE CustomerID = ? AND IsBlocked = 0";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, fullName);

            if (phone == null || phone.trim().isEmpty()) {
                ps.setNull(2, java.sql.Types.VARCHAR);
            } else {
                ps.setString(2, phone.trim());
            }

            if (dateOfBirth != null) {
                ps.setDate(3, Date.valueOf(dateOfBirth));
            } else {
                ps.setNull(3, java.sql.Types.DATE);
            }

            if (gender != null) {
                ps.setInt(4, gender);
            } else {
                ps.setNull(4, java.sql.Types.TINYINT);
            }

            ps.setInt(5, customerId);

            return ps.executeUpdate() > 0;
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    // ===== PROFILE: Get password hash (verify current password) =====
    public String getPasswordHashById(int customerId) throws Exception {
        String sql = "SELECT PasswordHash FROM Customer WHERE CustomerID = ? AND IsBlocked = 0";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("PasswordHash");
                }
            }
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
        return null;
    }

    // ===== PROFILE: Change password (set PasswordHash) =====
    public boolean changePassword(int customerId, String newPasswordHash) throws Exception {
        String sql = "UPDATE Customer "
                + "SET PasswordHash = ?, UpdatedAt = SYSDATETIME() "
                + "WHERE CustomerID = ? AND IsBlocked = 0";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, newPasswordHash);
            ps.setInt(2, customerId);
            return ps.executeUpdate() > 0;
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

}
