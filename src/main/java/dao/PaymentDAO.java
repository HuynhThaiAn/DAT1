package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import model.Payment;
import utils.DBContext;

public class PaymentDAO {

    // Insert Payment dùng CHUNG connection (để nằm trong transaction của OrderDAO)
    public void insert(Connection con,
            int orderId,
            int method,
            BigDecimal amount,
            int status,
            String transactionCode) throws Exception {

        String sql
                = "INSERT INTO Payment (OrderID, Method, Amount, Status, TransactionCode, PaidAt, CreatedAt) "
                + "VALUES (?, ?, ?, ?, ?, NULL, SYSDATETIME())";

        try ( PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, method);
            ps.setBigDecimal(3, amount);
            ps.setInt(4, status);
            ps.setString(5, transactionCode);
            ps.executeUpdate();
        }
    }

    public Payment getByOrderId(int orderId) throws Exception {
        String sql
                = "SELECT PaymentID, OrderID, Method, Amount, Status, TransactionCode, PaidAt, CreatedAt "
                + "FROM Payment WHERE OrderID = ?";

        DBContext db = new DBContext();
        try ( PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Payment p = new Payment();
                p.setPaymentID(rs.getInt("PaymentID"));
                p.setOrderID(rs.getInt("OrderID"));
                p.setMethod(rs.getInt("Method"));
                p.setAmount(rs.getBigDecimal("Amount"));
                p.setStatus(rs.getInt("Status"));
                p.setTransactionCode(rs.getString("TransactionCode"));

                Timestamp paidAt = rs.getTimestamp("PaidAt");
                p.setPaidAt(paidAt == null ? null : paidAt.toLocalDateTime());

                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                p.setCreatedAt(createdAt == null ? null : createdAt.toLocalDateTime());

                return p;
            }
        } finally {
            if (db.conn != null) {
                db.conn.close();
            }
        }
    }
}
