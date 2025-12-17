package dao;

import model.Brand;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {

    public List<Brand> getAll() throws Exception {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT BrandID, BrandName, Description, LogoUrl, IsDeleted, CreatedAt, UpdatedAt "
                   + "FROM Brand WHERE IsDeleted = 0 ORDER BY BrandID DESC";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapBrand(rs));
            }
            return list;

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public Brand getById(int id) throws Exception {
        String sql = "SELECT BrandID, BrandName, Description, LogoUrl, IsDeleted, CreatedAt, UpdatedAt "
                   + "FROM Brand WHERE BrandID = ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return mapBrand(rs);
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public boolean existsByName(String name) throws Exception {
        String sql = "SELECT 1 FROM Brand WHERE BrandName = ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, name);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public boolean existsByNameExceptId(String name, int id) throws Exception {
        String sql = "SELECT 1 FROM Brand WHERE BrandName = ? AND BrandID <> ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, id);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void insert(Brand b) throws Exception {
        String sql = "INSERT INTO Brand(BrandName, Description, LogoUrl, CreatedAt, IsDeleted) "
                   + "VALUES (?, ?, ?, SYSDATETIME(), 0)";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, b.getBrandName());
            ps.setString(2, b.getDescription());
            ps.setString(3, b.getLogoUrl());
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void update(Brand b) throws Exception {
        String sql = "UPDATE Brand "
                   + "SET BrandName=?, Description=?, LogoUrl=?, UpdatedAt=SYSDATETIME() "
                   + "WHERE BrandID=? AND IsDeleted=0";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, b.getBrandName());
            ps.setString(2, b.getDescription());
            ps.setString(3, b.getLogoUrl());
            ps.setInt(4, b.getBrandID());
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void softDelete(int id) throws Exception {
        String sql = "UPDATE Brand SET IsDeleted=1, UpdatedAt=SYSDATETIME() WHERE BrandID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    private Brand mapBrand(ResultSet rs) throws Exception {
        Brand b = new Brand();
        b.setBrandID(rs.getInt("BrandID"));
        b.setBrandName(rs.getString("BrandName"));
        b.setDescription(rs.getString("Description"));
        b.setLogoUrl(rs.getString("LogoUrl"));
        b.setIsDeleted(rs.getBoolean("IsDeleted"));

        Timestamp created = rs.getTimestamp("CreatedAt");
        if (created != null) b.setCreatedAt(created.toLocalDateTime());

        Timestamp updated = rs.getTimestamp("UpdatedAt");
        if (updated != null) b.setUpdatedAt(updated.toLocalDateTime());

        return b;
    }
}
