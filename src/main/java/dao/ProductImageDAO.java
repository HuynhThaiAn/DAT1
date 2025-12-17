package dao;

import model.ProductImage;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO {

    public List<ProductImage> getByProductId(int productId) throws Exception {
        List<ProductImage> list = new ArrayList<>();
        String sql = "SELECT ImageID, ProductID, ImageUrl, IsMain, CreatedAt "
                + "FROM ProductImage WHERE ProductID=? ORDER BY IsMain DESC, ImageID DESC";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductImage img = new ProductImage();
                    img.setImageID(rs.getInt("ImageID"));
                    img.setProductID(rs.getInt("ProductID"));
                    img.setImageUrl(rs.getString("ImageUrl"));
                    boolean isMain = rs.getBoolean("IsMain");
                    img.setIsMain(rs.wasNull() ? null : isMain);

                    Timestamp created = rs.getTimestamp("CreatedAt");
                    if (created != null) {
                        img.setCreatedAt(created.toLocalDateTime());
                    }

                    list.add(img);
                }
            }
            return list;

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public void insert(int productId, String imageUrl, boolean isMain) throws Exception {
        String sql = "INSERT INTO ProductImage(ProductID, ImageUrl, IsMain, CreatedAt) "
                + "VALUES (?, ?, ?, SYSDATETIME())";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, imageUrl);
            ps.setBoolean(3, isMain);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    // Set ảnh main: reset tất cả về 0 rồi set 1 cho imageId
    public void setMain(int productId, int imageId) throws Exception {
        String sql1 = "UPDATE ProductImage SET IsMain=0 WHERE ProductID=?";
        String sql2 = "UPDATE ProductImage SET IsMain=1 WHERE ProductID=? AND ImageID=?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps1 = db.conn.prepareStatement(sql1);  PreparedStatement ps2 = db.conn.prepareStatement(sql2)) {

            ps1.setInt(1, productId);
            ps1.executeUpdate();

            ps2.setInt(1, productId);
            ps2.setInt(2, imageId);
            ps2.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    // Bước 1: insert ảnh main (đảm bảo chỉ 1 ảnh main)
    public void insertMainImage(int productId, String imageUrl) throws Exception {
        String reset = "UPDATE ProductImage SET IsMain=0 WHERE ProductID=?";
        String insert = "INSERT INTO ProductImage(ProductID, ImageUrl, IsMain, CreatedAt) VALUES (?, ?, 1, SYSDATETIME())";

        DBContext db = new DBContext();
        try ( PreparedStatement ps1 = db.conn.prepareStatement(reset);  PreparedStatement ps2 = db.conn.prepareStatement(insert)) {

            ps1.setInt(1, productId);
            ps1.executeUpdate();

            ps2.setInt(1, productId);
            ps2.setString(2, imageUrl);
            ps2.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public void delete(int imageId) throws Exception {
        String sql = "DELETE FROM ProductImage WHERE ImageID=?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, imageId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }
}
