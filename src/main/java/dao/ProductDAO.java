package dao;

import model.Product;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getAll() throws Exception {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT ProductID, CategoryID, BrandID, ProductName, Description, IsDeleted, CreatedAt, UpdatedAt "
                + "FROM Product WHERE IsDeleted = 0 ORDER BY ProductID DESC";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setProductID(rs.getInt("ProductID"));
                p.setCategoryID(rs.getInt("CategoryID"));

                int brandId = rs.getInt("BrandID");
                if (!rs.wasNull()) {
                    p.setBrandID(brandId);
                } else {
                    p.setBrandID(null);
                }

                p.setProductName(rs.getString("ProductName"));
                p.setDescription(rs.getString("Description"));
                p.setIsDeleted(rs.getBoolean("IsDeleted"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) {
                    p.setCreatedAt(created.toLocalDateTime());
                }

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) {
                    p.setUpdatedAt(updated.toLocalDateTime());
                }

                list.add(p);
            }
            return list;

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public Product getById(int id) throws Exception {
        String sql = "SELECT ProductID, CategoryID, BrandID, ProductName, Description, IsDeleted, CreatedAt, UpdatedAt "
                + "FROM Product WHERE ProductID = ? AND IsDeleted = 0";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try ( ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Product p = new Product();
                p.setProductID(rs.getInt("ProductID"));
                p.setCategoryID(rs.getInt("CategoryID"));

                int brandId = rs.getInt("BrandID");
                if (!rs.wasNull()) {
                    p.setBrandID(brandId);
                } else {
                    p.setBrandID(null);
                }

                p.setProductName(rs.getString("ProductName"));
                p.setDescription(rs.getString("Description"));
                p.setIsDeleted(rs.getBoolean("IsDeleted"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) {
                    p.setCreatedAt(created.toLocalDateTime());
                }

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) {
                    p.setUpdatedAt(updated.toLocalDateTime());
                }

                return p;
            }

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    // Insert Product và trả về ProductID (dùng cho bước 1)
    public int insertAndGetId(Product p) throws Exception {
        String sql = "INSERT INTO Product(CategoryID, BrandID, ProductName, Description, CreatedAt, IsDeleted) "
                + "VALUES (?, ?, ?, ?, SYSDATETIME(), 0)";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getCategoryID());

            if (p.getBrandID() != null) {
                ps.setInt(2, p.getBrandID());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setString(3, p.getProductName());
            ps.setString(4, p.getDescription());

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

    public void update(Product p) throws Exception {
        String sql = "UPDATE Product "
                + "SET CategoryID=?, BrandID=?, ProductName=?, Description=?, UpdatedAt=SYSDATETIME() "
                + "WHERE ProductID=? AND IsDeleted=0";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, p.getCategoryID());

            if (p.getBrandID() != null) {
                ps.setInt(2, p.getBrandID());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setString(3, p.getProductName());
            ps.setString(4, p.getDescription());
            ps.setInt(5, p.getProductID());

            ps.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public void softDelete(int productId) throws Exception {
        String sql = "UPDATE Product SET IsDeleted=1, UpdatedAt=SYSDATETIME() WHERE ProductID=?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public List<Product> getTop10Newest() throws Exception {
        return getTopNewest(10);
    }

    public List<Product> getTopNewest(int top) throws Exception {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP (?) ProductID, CategoryID, BrandID, ProductName, Description, IsDeleted, CreatedAt, UpdatedAt "
                + "FROM Product WHERE IsDeleted = 0 "
                + "ORDER BY CreatedAt DESC, ProductID DESC";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, top);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductID(rs.getInt("ProductID"));
                    p.setCategoryID(rs.getInt("CategoryID"));

                    int brandId = rs.getInt("BrandID");
                    if (!rs.wasNull()) {
                        p.setBrandID(brandId);
                    } else {
                        p.setBrandID(null);
                    }

                    p.setProductName(rs.getString("ProductName"));
                    p.setDescription(rs.getString("Description"));
                    p.setIsDeleted(rs.getBoolean("IsDeleted"));

                    Timestamp created = rs.getTimestamp("CreatedAt");
                    if (created != null) {
                        p.setCreatedAt(created.toLocalDateTime());
                    }

                    Timestamp updated = rs.getTimestamp("UpdatedAt");
                    if (updated != null) {
                        p.setUpdatedAt(updated.toLocalDateTime());
                    }

                    list.add(p);
                }
            }
            return list;

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public List<Product> filter(Integer categoryId, Integer brandId, String keyword) throws Exception {
        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT ProductID, CategoryID, BrandID, ProductName, Description, IsDeleted, CreatedAt, UpdatedAt "
                + "FROM Product WHERE IsDeleted = 0 "
        );

        if (categoryId != null && categoryId > 0) {
            sql.append(" AND CategoryID = ? ");
        }
        if (brandId != null && brandId > 0) {
            sql.append(" AND BrandID = ? ");
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND ProductName LIKE ? ");
        }

        sql.append(" ORDER BY ProductID DESC");

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql.toString())) {

            int i = 1;
            if (categoryId != null && categoryId > 0) {
                ps.setInt(i++, categoryId);
            }
            if (brandId != null && brandId > 0) {
                ps.setInt(i++, brandId);
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(i++, "%" + keyword.trim() + "%");
            }

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductID(rs.getInt("ProductID"));
                    p.setCategoryID(rs.getInt("CategoryID"));

                    int bid = rs.getInt("BrandID");
                    p.setBrandID(rs.wasNull() ? null : bid);

                    p.setProductName(rs.getString("ProductName"));
                    p.setDescription(rs.getString("Description"));

                    Timestamp created = rs.getTimestamp("CreatedAt");
                    p.setCreatedAt(created == null ? null : created.toLocalDateTime());

                    Timestamp updated = rs.getTimestamp("UpdatedAt");
                    p.setUpdatedAt(updated == null ? null : updated.toLocalDateTime());

                    list.add(p);
                }
            }
            return list;

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

}
