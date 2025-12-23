package dao;

import model.Cart;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.CartViewItem;

public class CartDAO {

    // ============ BASIC (Cart table) ============
    public List<Cart> getByCustomerId(int customerId) throws Exception {
        List<Cart> list = new ArrayList<>();
        String sql = "SELECT CustomerID, ProductVariantID, Quantity, AddedAt, UpdatedAt "
                + "FROM Cart WHERE CustomerID = ? "
                + "ORDER BY COALESCE(UpdatedAt, AddedAt) DESC";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapCart(rs));
                }
            }
            return list;

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public Cart getItem(int customerId, int productVariantId) throws Exception {
        String sql = "SELECT CustomerID, ProductVariantID, Quantity, AddedAt, UpdatedAt "
                + "FROM Cart WHERE CustomerID = ? AND ProductVariantID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productVariantId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                return mapCart(rs);
            }

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    /**
     * Add to cart theo kiểu UPSERT: - Nếu đã có row -> Quantity = Quantity +
     * qty - Nếu chưa -> INSERT mới
     *
     * Lưu ý: dùng 2 bước SELECT + (UPDATE/INSERT) theo style bạn đang dùng.
     */
    public void addOrIncrease(int customerId, int productVariantId, int qty) throws Exception {
        if (qty <= 0) {
            return;
        }

        String checkSql = "SELECT Quantity FROM Cart WHERE CustomerID = ? AND ProductVariantID = ?";
        String updateSql = "UPDATE Cart SET Quantity = Quantity + ?, UpdatedAt = SYSDATETIME() "
                + "WHERE CustomerID = ? AND ProductVariantID = ?";
        String insertSql = "INSERT INTO Cart(CustomerID, ProductVariantID, Quantity, AddedAt, UpdatedAt) "
                + "VALUES (?, ?, ?, SYSDATETIME(), NULL)";

        DBContext db = new DBContext();
        try {
            // 1) check exists
            boolean exists = false;
            try ( PreparedStatement ps = db.conn.prepareStatement(checkSql)) {
                ps.setInt(1, customerId);
                ps.setInt(2, productVariantId);

                try ( ResultSet rs = ps.executeQuery()) {
                    exists = rs.next();
                }
            }

            // 2) update or insert
            if (exists) {
                try ( PreparedStatement ps = db.conn.prepareStatement(updateSql)) {
                    ps.setInt(1, qty);
                    ps.setInt(2, customerId);
                    ps.setInt(3, productVariantId);
                    ps.executeUpdate();
                }
            } else {
                try ( PreparedStatement ps = db.conn.prepareStatement(insertSql)) {
                    ps.setInt(1, customerId);
                    ps.setInt(2, productVariantId);
                    ps.setInt(3, qty);
                    ps.executeUpdate();
                }
            }

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    /**
     * Update qty: nếu qty <= 0 thì remove luôn (giỏ hàng thường làm vậy).
     */
    public void updateQuantity(int customerId, int productVariantId, int qty) throws Exception {
        DBContext db = new DBContext();
        try {
            if (qty <= 0) {
                String delSql = "DELETE FROM Cart WHERE CustomerID = ? AND ProductVariantID = ?";
                try ( PreparedStatement ps = db.conn.prepareStatement(delSql)) {
                    ps.setInt(1, customerId);
                    ps.setInt(2, productVariantId);
                    ps.executeUpdate();
                }
                return;
            }

            String sql = "UPDATE Cart SET Quantity = ?, UpdatedAt = SYSDATETIME() "
                    + "WHERE CustomerID = ? AND ProductVariantID = ?";

            try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
                ps.setInt(1, qty);
                ps.setInt(2, customerId);
                ps.setInt(3, productVariantId);
                ps.executeUpdate();
            }

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public void removeItem(int customerId, int productVariantId) throws Exception {
        String sql = "DELETE FROM Cart WHERE CustomerID = ? AND ProductVariantID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productVariantId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public void clearCart(int customerId) throws Exception {
        String sql = "DELETE FROM Cart WHERE CustomerID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public int getTotalQuantity(int customerId) throws Exception {
        String sql = "SELECT COALESCE(SUM(Quantity), 0) AS TotalQty FROM Cart WHERE CustomerID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("TotalQty");
                }
                return 0;
            }

        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    private Cart mapCart(ResultSet rs) throws Exception {
        Cart c = new Cart();
        c.setCustomerID(rs.getInt("CustomerID"));
        c.setProductVariantID(rs.getInt("ProductVariantID"));
        c.setQuantity(rs.getInt("Quantity"));

        Timestamp added = rs.getTimestamp("AddedAt");
        if (added != null) {
            c.setAddedAt(added.toLocalDateTime());
        }

        Timestamp updated = rs.getTimestamp("UpdatedAt");
        if (updated != null) {
            c.setUpdatedAt(updated.toLocalDateTime());
        }

        return c;
    }

    public List<CartViewItem> getCartViewItems(int customerId) throws Exception {
        List<CartViewItem> list = new ArrayList<>();

        // Lấy dữ liệu để hiển thị giỏ hàng (JOIN Cart + ProductVariant + Product)
        // Lọc sản phẩm bị xoá mềm và variant inactive để tránh "tồn kho ảo"
        String sql
                = "SELECT c.ProductVariantID, c.Quantity, "
                + "       p.ProductID, p.ProductName, "
                + "       pv.VariantName, pv.SKU, pv.Price, pv.StockQuantity "
                + "FROM Cart c "
                + "JOIN ProductVariant pv ON pv.ProductVariantID = c.ProductVariantID "
                + "JOIN Product p ON p.ProductID = pv.ProductID "
                + "WHERE c.CustomerID = ? "
                + "  AND p.IsDeleted = 0 "
                + "  AND pv.IsActive = 1 "
                + "ORDER BY COALESCE(c.UpdatedAt, c.AddedAt) DESC";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartViewItem item = new CartViewItem();
                    item.setProductID(rs.getInt("ProductID"));
                    item.setProductVariantID(rs.getInt("ProductVariantID"));
                    item.setProductName(rs.getString("ProductName"));
                    item.setVariantName(rs.getString("VariantName"));
                    item.setSKU(rs.getString("SKU"));
                    item.setPrice(rs.getBigDecimal("Price"));
                    item.setStockQuantity(rs.getInt("StockQuantity"));
                    item.setQuantity(rs.getInt("Quantity"));
                    list.add(item);
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
