package dao;

import model.CartViewItem;
import utils.DBContext;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;

public class OrderDAO {

    // Payment Status
    // 0 = Pending, 1 = Paid, 2 = Failed
    private static final int PAYMENT_PENDING = 0;

    public int createOrderFromCart(int customerId,
            int addressId,
            String receiverName,
            String phone,
            String note,
            int paymentMethod,
            List<CartViewItem> cartItems) throws Exception {

        if (cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("Cart is empty.");
        }

        DBContext db = new DBContext();
        Connection con = db.conn;

        try {
            con.setAutoCommit(false);

            // 1) Recheck stock + lấy price hiện tại (lock để tránh oversell)
            BigDecimal total = BigDecimal.ZERO;

            String lockSql
                    = "SELECT pv.Price, pv.StockQuantity, pv.IsActive, p.IsDeleted "
                    + "FROM ProductVariant pv WITH (UPDLOCK, ROWLOCK) "
                    + "JOIN Product p ON p.ProductID = pv.ProductID "
                    + "WHERE pv.ProductVariantID = ?";

            for (CartViewItem item : cartItems) {
                int variantId = item.getProductVariantID();
                int qty = (item.getQuantity() == null) ? 0 : item.getQuantity();
                if (qty <= 0) {
                    throw new IllegalArgumentException("Invalid qty in cart.");
                }

                try ( PreparedStatement ps = con.prepareStatement(lockSql)) {
                    ps.setInt(1, variantId);

                    try ( ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new IllegalArgumentException("Variant not found: " + variantId);
                        }

                        boolean isActive = rs.getBoolean("IsActive");
                        boolean isDeleted = rs.getBoolean("IsDeleted");
                        int stock = rs.getInt("StockQuantity");
                        BigDecimal price = rs.getBigDecimal("Price");

                        if (isDeleted) {
                            throw new IllegalArgumentException("Product is deleted.");
                        }
                        if (!isActive) {
                            throw new IllegalArgumentException("Variant inactive.");
                        }
                        if (stock < qty) {
                            throw new IllegalArgumentException("Not enough stock for variant: " + variantId);
                        }

                        // đóng băng giá lúc đặt
                        item.setPrice(price);
                        total = total.add(price.multiply(BigDecimal.valueOf(qty)));
                    }
                }
            }

            // 2) Insert Order -> lấy OrderID
            int orderId;

            String insertOrderSql
                    = "INSERT INTO [Order] (CustomerID, AddressID, TotalAmount, Status, Note, OrderedAt, ReceiverName, Phone) "
                    + "VALUES (?, ?, ?, ?, ?, SYSDATETIME(), ?, ?); "
                    + "SELECT SCOPE_IDENTITY() AS NewOrderID;";

            try ( PreparedStatement ps = con.prepareStatement(insertOrderSql)) {
                ps.setInt(1, customerId);
                ps.setInt(2, addressId);
                ps.setBigDecimal(3, total);
                ps.setInt(4, 0); // Order Status Pending (bạn có thể đổi)
                ps.setString(5, note);
                ps.setString(6, receiverName);
                ps.setString(7, phone);

                try ( ResultSet rs = ps.executeQuery()) {
                    rs.next();
                    orderId = rs.getInt("NewOrderID");
                }
            }

            // 3) Insert OrderDetail
            String insertDetailSql
                    = "INSERT INTO OrderDetail (OrderID, ProductVariantID, UnitPrice, Quantity) "
                    + "VALUES (?, ?, ?, ?)";

            try ( PreparedStatement ps = con.prepareStatement(insertDetailSql)) {
                for (CartViewItem item : cartItems) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getProductVariantID());
                    ps.setBigDecimal(3, item.getPrice());
                    ps.setInt(4, item.getQuantity());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            // 4) Trừ kho
            String updateStockSql
                    = "UPDATE ProductVariant "
                    + "SET StockQuantity = StockQuantity - ?, UpdatedAt = SYSDATETIME() "
                    + "WHERE ProductVariantID = ?";

            try ( PreparedStatement ps = con.prepareStatement(updateStockSql)) {
                for (CartViewItem item : cartItems) {
                    ps.setInt(1, item.getQuantity());
                    ps.setInt(2, item.getProductVariantID());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            // 5) Insert Payment (place order xong luôn SUCCESS tạo đơn, nhưng payment vẫn PENDING)
            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.insert(con, orderId, paymentMethod, total, PAYMENT_PENDING, null);

            // 6) Clear cart
            String clearCartSql = "DELETE FROM Cart WHERE CustomerID = ?";
            try ( PreparedStatement ps = con.prepareStatement(clearCartSql)) {
                ps.setInt(1, customerId);
                ps.executeUpdate();
            }

            con.commit();
            return orderId;

        } catch (Exception ex) {
            try {
                con.rollback();
            } catch (Exception ignore) {
            }
            throw ex;

        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ignore) {
            }
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    // ====== LIST ORDER HISTORY (by Customer) ======
    public List<Order> getOrdersByCustomerId(int customerId) throws Exception {
        List<Order> list = new ArrayList<>();

        String sql
                = "SELECT OrderID, CustomerID, AddressID, ReceiverName, Phone, TotalAmount, Status, "
                + "       OrderedAt, PaidAt, ShippedAt, DeliveredAt, CancelledAt, Note "
                + "FROM [Order] "
                + "WHERE CustomerID = ? "
                + "ORDER BY OrderedAt DESC";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt("OrderID"));
                    o.setCustomerID(rs.getInt("CustomerID"));
                    o.setAddressID(rs.getInt("AddressID"));
                    o.setReceiverName(rs.getString("ReceiverName"));
                    o.setPhone(rs.getString("Phone"));
                    o.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                    o.setStatus(rs.getInt("Status"));
                    o.setNote(rs.getString("Note"));

                    Timestamp t;
                    t = rs.getTimestamp("OrderedAt");
                    o.setOrderedAt(t == null ? null : t.toLocalDateTime());
                    t = rs.getTimestamp("PaidAt");
                    o.setPaidAt(t == null ? null : t.toLocalDateTime());
                    t = rs.getTimestamp("ShippedAt");
                    o.setShippedAt(t == null ? null : t.toLocalDateTime());
                    t = rs.getTimestamp("DeliveredAt");
                    o.setDeliveredAt(t == null ? null : t.toLocalDateTime());
                    t = rs.getTimestamp("CancelledAt");
                    o.setCancelledAt(t == null ? null : t.toLocalDateTime());

                    list.add(o);
                }
            }
            return list;
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    public Order getOrderByIdAndCustomerId(int orderId, int customerId) throws Exception {
        String sql
                = "SELECT OrderID, CustomerID, AddressID, ReceiverName, Phone, TotalAmount, Status, "
                + "       OrderedAt, PaidAt, ShippedAt, DeliveredAt, CancelledAt, Note "
                + "FROM [Order] "
                + "WHERE OrderID = ? AND CustomerID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, customerId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Order o = new Order();
                o.setOrderID(rs.getInt("OrderID"));
                o.setCustomerID(rs.getInt("CustomerID"));
                o.setAddressID(rs.getInt("AddressID"));
                o.setReceiverName(rs.getString("ReceiverName"));
                o.setPhone(rs.getString("Phone"));
                o.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                o.setStatus(rs.getInt("Status"));
                o.setNote(rs.getString("Note"));

                Timestamp t;
                t = rs.getTimestamp("OrderedAt");
                o.setOrderedAt(t == null ? null : t.toLocalDateTime());
                t = rs.getTimestamp("PaidAt");
                o.setPaidAt(t == null ? null : t.toLocalDateTime());
                t = rs.getTimestamp("ShippedAt");
                o.setShippedAt(t == null ? null : t.toLocalDateTime());
                t = rs.getTimestamp("DeliveredAt");
                o.setDeliveredAt(t == null ? null : t.toLocalDateTime());
                t = rs.getTimestamp("CancelledAt");
                o.setCancelledAt(t == null ? null : t.toLocalDateTime());

                return o;
            }
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }

    // ====== ORDER DETAILS ======
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws Exception {
        List<OrderDetail> list = new ArrayList<>();

        String sql
                = "SELECT OrderID, ProductVariantID, UnitPrice, Quantity "
                + "FROM OrderDetail "
                + "WHERE OrderID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail d = new OrderDetail();
                    d.setOrderID(rs.getInt("OrderID"));
                    d.setProductVariantID(rs.getInt("ProductVariantID"));
                    d.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                    d.setQuantity(rs.getInt("Quantity"));
                    list.add(d);
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
