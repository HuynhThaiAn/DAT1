package dao;

import model.Staff;
import utils.DBContext;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    public List<Staff> getAll() throws Exception {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT StaffID, Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, Role, IsDeleted, CreatedAt, UpdatedAt "
                   + "FROM Staff WHERE IsDeleted = 0 ORDER BY StaffID DESC";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Staff s = new Staff();
                s.setStaffID(rs.getInt("StaffID"));
                s.setEmail(rs.getString("Email"));
                s.setPasswordHash(rs.getString("PasswordHash"));
                s.setFullName(rs.getString("FullName"));
                s.setPhone(rs.getString("Phone"));

                Date dob = rs.getDate("DateOfBirth");
                if (dob != null) s.setDateOfBirth(dob.toLocalDate());

                int gender = rs.getInt("Gender");
                if (!rs.wasNull()) s.setGender(gender);

                int role = rs.getInt("Role");
                if (!rs.wasNull()) s.setRole(role);

                s.setIsDeleted(rs.getBoolean("IsDeleted"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) s.setCreatedAt(created.toLocalDateTime());

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) s.setUpdatedAt(updated.toLocalDateTime());

                list.add(s);
            }
            return list;

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public Staff getById(int id) throws Exception {
        String sql = "SELECT StaffID, Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, Role, IsDeleted, CreatedAt, UpdatedAt "
                   + "FROM Staff WHERE StaffID = ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                Staff s = new Staff();
                s.setStaffID(rs.getInt("StaffID"));
                s.setEmail(rs.getString("Email"));
                s.setPasswordHash(rs.getString("PasswordHash"));
                s.setFullName(rs.getString("FullName"));
                s.setPhone(rs.getString("Phone"));

                Date dob = rs.getDate("DateOfBirth");
                if (dob != null) s.setDateOfBirth(dob.toLocalDate());

                int gender = rs.getInt("Gender");
                if (!rs.wasNull()) s.setGender(gender);

                int role = rs.getInt("Role");
                if (!rs.wasNull()) s.setRole(role);

                s.setIsDeleted(rs.getBoolean("IsDeleted"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) s.setCreatedAt(created.toLocalDateTime());

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) s.setUpdatedAt(updated.toLocalDateTime());

                return s;
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public boolean existsByEmail(String email) throws Exception {
        String sql = "SELECT 1 FROM Staff WHERE Email = ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public boolean existsByEmailExceptId(String email, int id) throws Exception {
        String sql = "SELECT 1 FROM Staff WHERE Email = ? AND StaffID <> ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void insert(Staff s) throws Exception {
        String sql = "INSERT INTO Staff(Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, Role, IsDeleted, CreatedAt) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, 0, SYSDATETIME())";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, s.getEmail());
            ps.setString(2, s.getPasswordHash());
            ps.setString(3, s.getFullName());
            ps.setString(4, s.getPhone());

            if (s.getDateOfBirth() != null) ps.setDate(5, Date.valueOf(s.getDateOfBirth()));
            else ps.setNull(5, java.sql.Types.DATE);

            if (s.getGender() != null) ps.setInt(6, s.getGender());
            else ps.setNull(6, java.sql.Types.INTEGER);

            if (s.getRole() != null) ps.setInt(7, s.getRole());
            else ps.setNull(7, java.sql.Types.INTEGER);

            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void update(Staff s) throws Exception {
        String sql = "UPDATE Staff "
                   + "SET Email=?, PasswordHash=?, FullName=?, Phone=?, DateOfBirth=?, Gender=?, Role=?, UpdatedAt=SYSDATETIME() "
                   + "WHERE StaffID=? AND IsDeleted=0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, s.getEmail());
            ps.setString(2, s.getPasswordHash());
            ps.setString(3, s.getFullName());
            ps.setString(4, s.getPhone());

            if (s.getDateOfBirth() != null) ps.setDate(5, Date.valueOf(s.getDateOfBirth()));
            else ps.setNull(5, java.sql.Types.DATE);

            if (s.getGender() != null) ps.setInt(6, s.getGender());
            else ps.setNull(6, java.sql.Types.INTEGER);

            if (s.getRole() != null) ps.setInt(7, s.getRole());
            else ps.setNull(7, java.sql.Types.INTEGER);

            ps.setInt(8, s.getStaffID());

            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void softDelete(int id) throws Exception {
        String sql = "UPDATE Staff SET IsDeleted=1, UpdatedAt=SYSDATETIME() WHERE StaffID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }
    
    public Staff login(String email, String passwordHash) throws Exception {
        String sql = "SELECT StaffID, Email, PasswordHash, FullName, Phone, DateOfBirth, Gender, Role, IsDeleted, CreatedAt, UpdatedAt "
                   + "FROM Staff WHERE Email=? AND PasswordHash=? AND IsDeleted=0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, passwordHash);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                Staff s = new Staff();
                s.setStaffID(rs.getInt("StaffID"));
                s.setEmail(rs.getString("Email"));
                s.setPasswordHash(rs.getString("PasswordHash"));
                s.setFullName(rs.getString("FullName"));
                s.setPhone(rs.getString("Phone"));

                Date dob = rs.getDate("DateOfBirth");
                if (dob != null) s.setDateOfBirth(dob.toLocalDate());

                int gender = rs.getInt("Gender");
                if (!rs.wasNull()) s.setGender(gender);

                int role = rs.getInt("Role");
                if (!rs.wasNull()) s.setRole(role);

                s.setIsDeleted(rs.getBoolean("IsDeleted"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) s.setCreatedAt(created.toLocalDateTime());

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) s.setUpdatedAt(updated.toLocalDateTime());

                return s;
            }
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }
}
