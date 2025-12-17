package dao;

import model.ProductVariant;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAO {

    public List<ProductVariant> getByProductId(int productId) throws Exception {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT ProductVariantID, ProductID, SKU, VariantName, Price, StockQuantity, IsActive, CreatedAt, UpdatedAt "
                   + "FROM ProductVariant WHERE ProductID=? ORDER BY ProductVariantID DESC";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setProductVariantID(rs.getInt("ProductVariantID"));
                    v.setProductID(rs.getInt("ProductID"));
                    v.setSKU(rs.getString("SKU"));
                    v.setVariantName(rs.getString("VariantName"));
                    v.setPrice(rs.getBigDecimal("Price"));
                    v.setStockQuantity(rs.getInt("StockQuantity"));
                    v.setIsActive(rs.getBoolean("IsActive"));

                    Timestamp created = rs.getTimestamp("CreatedAt");
                    if (created != null) v.setCreatedAt(created.toLocalDateTime());

                    Timestamp updated = rs.getTimestamp("UpdatedAt");
                    if (updated != null) v.setUpdatedAt(updated.toLocalDateTime());

                    list.add(v);
                }
            }
            return list;

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public ProductVariant getById(int id) throws Exception {
        String sql = "SELECT ProductVariantID, ProductID, SKU, VariantName, Price, StockQuantity, IsActive, CreatedAt, UpdatedAt "
                   + "FROM ProductVariant WHERE ProductVariantID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                ProductVariant v = new ProductVariant();
                v.setProductVariantID(rs.getInt("ProductVariantID"));
                v.setProductID(rs.getInt("ProductID"));
                v.setSKU(rs.getString("SKU"));
                v.setVariantName(rs.getString("VariantName"));
                v.setPrice(rs.getBigDecimal("Price"));
                v.setStockQuantity(rs.getInt("StockQuantity"));
                v.setIsActive(rs.getBoolean("IsActive"));

                Timestamp created = rs.getTimestamp("CreatedAt");
                if (created != null) v.setCreatedAt(created.toLocalDateTime());

                Timestamp updated = rs.getTimestamp("UpdatedAt");
                if (updated != null) v.setUpdatedAt(updated.toLocalDateTime());

                return v;
            }

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    // Insert variant và trả về ProductVariantID
    // StockQuantity mặc định 0 nếu bạn không set trong model => ở đây nếu null thì set 0.
    public int insertAndGetId(ProductVariant v) throws Exception {
        String sql = "INSERT INTO ProductVariant(ProductID, SKU, VariantName, Price, StockQuantity, IsActive, CreatedAt) "
                   + "VALUES (?, ?, ?, ?, ?, ?, SYSDATETIME())";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, v.getProductID());
            ps.setString(2, v.getSKU());
            ps.setString(3, v.getVariantName());
            ps.setBigDecimal(4, v.getPrice());

            // stock default 0
            ps.setInt(5, v.getStockQuantity() == null ? 0 : v.getStockQuantity());

            // active default true
            ps.setBoolean(6, v.getIsActive() == null ? true : v.getIsActive());

            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
            return 0;

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void update(ProductVariant v) throws Exception {
        String sql = "UPDATE ProductVariant "
                   + "SET SKU=?, VariantName=?, Price=?, StockQuantity=?, IsActive=?, UpdatedAt=SYSDATETIME() "
                   + "WHERE ProductVariantID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setString(1, v.getSKU());
            ps.setString(2, v.getVariantName());
            ps.setBigDecimal(3, v.getPrice());
            ps.setInt(4, v.getStockQuantity() == null ? 0 : v.getStockQuantity());
            ps.setBoolean(5, v.getIsActive() == null ? true : v.getIsActive());
            ps.setInt(6, v.getProductVariantID());

            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    // "Xóa" variant theo kiểu tắt bán
    public void setActive(int variantId, boolean active) throws Exception {
        String sql = "UPDATE ProductVariant SET IsActive=?, UpdatedAt=SYSDATETIME() WHERE ProductVariantID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, variantId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }
}
