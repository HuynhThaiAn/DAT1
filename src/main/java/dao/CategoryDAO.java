package dao;

import model.Category;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAll() throws Exception {
        String sql = "SELECT CategoryID, CategoryName, Description, ImgUrlLogo "
                   + "FROM Category WHERE IsDeleted = 0 ORDER BY CategoryID DESC";
        DBContext db = new DBContext();
        List<Category> list = new ArrayList<>();

        try (PreparedStatement ps = db.conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                c.setDescription(rs.getString("Description"));
                c.setImgUrlLogo(rs.getString("ImgUrlLogo"));
                list.add(c);
            }
        } finally {
            if (db.conn != null) db.conn.close();
        }
        return list;
    }

    public Category getById(int id) throws Exception {
        String sql = "SELECT CategoryID, CategoryName, Description, ImgUrlLogo "
                   + "FROM Category WHERE CategoryID = ? AND IsDeleted = 0";
        DBContext db = new DBContext();

        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Category c = new Category();
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                c.setDescription(rs.getString("Description"));
                c.setImgUrlLogo(rs.getString("ImgUrlLogo"));
                return c;
            }
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public boolean existsByName(String name) throws Exception {
        String sql = "SELECT 1 FROM Category WHERE CategoryName = ?";
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
        String sql = "SELECT 1 FROM Category WHERE CategoryName = ? AND CategoryID <> ? AND IsDeleted = 0";
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

    public void insert(Category c) throws Exception {
        String sql = "INSERT INTO Category(CategoryName, Description, ImgUrlLogo, CreatedAt, IsDeleted) "
                   + "VALUES (?, ?, ?, SYSDATETIME(), 0)";
        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getImgUrlLogo());
            ps.executeUpdate();
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void update(Category c) throws Exception {
        String sql = "UPDATE Category "
                   + "SET CategoryName=?, Description=?, ImgUrlLogo=?, UpdatedAt=SYSDATETIME() "
                   + "WHERE CategoryID=? AND IsDeleted=0";
        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getDescription());
            ps.setString(3, c.getImgUrlLogo());
            ps.setInt(4, c.getCategoryID());
            ps.executeUpdate();
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void softDelete(int id) throws Exception {
        String sql = "UPDATE Category SET IsDeleted=1, UpdatedAt=SYSDATETIME() WHERE CategoryID=?";
        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            if (db.conn != null) db.conn.close();
        }
    }
}
