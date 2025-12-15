package dao;

import java.sql.*;
import java.util.*;
import model.*;
import utils.DBContext;

public class ImportStockDAO extends DBContext {

    public ArrayList<ImportStock> getAllImportStocks() {
        ArrayList<ImportStock> list = new ArrayList<>();
        String sql = "SELECT I.*, F.FullName "
                + "FROM ImportStocks I "
                + "JOIN Staff F ON I.StaffID = F.StaffID";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ImportStock io = extractImportStock(rs);
                io.setFullName(rs.getString("FullName"));
                list.add(io);
            }
        } catch (SQLException e) {
            System.out.println("getAllImportStocks: " + e.getMessage());
        }
        return list;
    }

    public ImportStock getImportStockByID(int id) {
        ImportStock io = null;
        String sql = "SELECT I.*, F.FullName "
                + "FROM ImportStocks I "
                + "JOIN Staff F ON I.StaffID = F.StaffID "
                + "WHERE I.ImportID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    io = extractImportStock(rs);
                    io.setFullName(rs.getString("FullName"));
                }
            }
        } catch (SQLException e) {
            System.out.println("getImportStockByID: " + e.getMessage());
        }
        return io;
    }

    /**
     * ❌ Bỏ supplier => method này không còn ý nghĩa.
     * Nếu vẫn muốn "search" thì chỉ có thể search theo ImportID hoặc Staff, Date...
     * Em để lại 1 phiên bản search theo Staff FullName cho tiện.
     */
    public ArrayList<ImportStock> getImportStockByStaffName(String name) {
        ArrayList<ImportStock> list = new ArrayList<>();
        String query = "SELECT I.*, F.FullName "
                + "FROM ImportStocks I "
                + "JOIN Staff F ON I.StaffID = F.StaffID "
                + "WHERE F.FullName LIKE ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ImportStock io = extractImportStock(rs);
                    io.setFullName(rs.getString("FullName"));
                    list.add(io);
                }
            }
        } catch (SQLException e) {
            System.out.println("getImportStockByStaffName: " + e.getMessage());
        }
        return list;
    }

    public ImportStock getImportStockDetailsByID(int id) {
        ImportStock io = getImportStockByID(id);
        if (io == null) return null;

        String query = "SELECT D.ImportID, P.ProductID, P.ProductName, D.Quantity, D.UnitPrice, D.QuantityLeft "
                + "FROM ImportStockDetails D "
                + "JOIN Products P ON D.ProductID = P.ProductID "
                + "WHERE D.ImportID = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            ArrayList<ImportStockDetail> detailsList = new ArrayList<>();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));

                ImportStockDetail detail = new ImportStockDetail(
                        rs.getInt("ImportID"),
                        p,
                        rs.getInt("Quantity"),
                        rs.getLong("UnitPrice"),
                        rs.getInt("QuantityLeft")
                );
                detailsList.add(detail);
            }
            io.setImportStockDetails(detailsList);

        } catch (SQLException e) {
            System.out.println("getImportStockDetailsByID: " + e.getMessage());
        }
        return io;
    }

    public int createImportStock(ImportStock io) {
        String query = "INSERT INTO ImportStocks (StaffID, SupplierID, ImportDate, TotalAmount, IsCompleted) "
                + "VALUES (?, ?, GETDATE(), ?, 1)";

        try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, io.getStaffId());
            ps.setInt(2, io.getSupplierId());   // ✅ vẫn lưu SupplierID trong bảng, chỉ là không join hiển thị
            ps.setLong(3, io.getTotalAmount());

            int affectedRows = ps.executeUpdate();
            System.out.println("affectedRows: " + affectedRows);

            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    System.out.println("Generated ImportID: " + id);
                    return id;
                }
            }

            Statement st = conn.createStatement();
            ResultSet rs2 = st.executeQuery("SELECT CAST(SCOPE_IDENTITY() AS INT) AS id");
            if (rs2.next()) {
                int id = rs2.getInt("id");
                System.out.println("SCOPE_IDENTITY fallback ImportID: " + id);
                return id;
            }

        } catch (SQLException e) {
            System.out.println("createImportStock ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    public int updateImportStockSupplier(int importId, int supplierId) {
        String query = "UPDATE ImportStocks SET SupplierID = ? WHERE ImportID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, supplierId);
            ps.setInt(2, importId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateImportStockSupplier: " + e.getMessage());
        }
        return -1;
    }

    public int importStock(List<Map<String, String>> stocks) {
        StringBuilder query = new StringBuilder("UPDATE Products SET Stock = Stock + CASE");
        StringBuilder ids = new StringBuilder("(");

        for (Map<String, String> map : stocks) {
            query.append(" WHEN ProductID = ").append(map.get("id"))
                 .append(" THEN ").append(map.get("stock"));
            ids.append(map.get("id")).append(",");
        }

        ids.setLength(ids.length() - 1);
        ids.append(")");

        query.append(" END WHERE ProductID IN ").append(ids);

        try (PreparedStatement ps = conn.prepareStatement(query.toString())) {
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("importStock: " + e.getMessage());
        }
        return -1;
    }

    private int completedImportStock(int importId, long total) {
        String query = "UPDATE ImportStocks SET IsCompleted = 1, ImportDate = GETDATE(), TotalAmount = ? WHERE ImportID = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, total);
            ps.setInt(2, importId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("completedImportStock: " + e.getMessage());
        }
        return -1;
    }

    // Method to import stock based on ImportID
    public int importStock(int importId) {
        String query = "UPDATE P SET P.Stock = P.Stock + D.Quantity "
                + "FROM Products P "
                + "INNER JOIN ImportStockDetails D ON P.ProductID = D.ProductID "
                + "WHERE D.ImportID = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, importId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("importStock by ID: " + e.getMessage());
        }
        return -1;
    }

    public ArrayList<ImportStock> filterHistoryByDate(String from, String to) {
        ArrayList<ImportStock> list = new ArrayList<>();
        String query = "SELECT I.*, F.FullName "
                + "FROM ImportStocks I "
                + "JOIN Staff F ON I.StaffID = F.StaffID "
                + "WHERE I.ImportDate BETWEEN ? AND ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, from + " 00:00:00");
            ps.setString(2, to + " 23:59:59");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ImportStock io = extractImportStock(rs);
                io.setFullName(rs.getString("FullName"));
                list.add(io);
            }
        } catch (SQLException e) {
            System.out.println("filterHistoryByDate: " + e.getMessage());
        }
        return list;
    }

    // ================== STATISTICS ===================
    public Map<String, Integer> getImportStocksCountByDate() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT CAST(ImportDate AS DATE) as ImportDate, SUM(TotalAmount) as TotalImport "
                   + "FROM ImportStocks GROUP BY CAST(ImportDate AS DATE) ORDER BY ImportDate";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("ImportDate"), rs.getInt("TotalImport"));
            }
        }
        return result;
    }

    public Map<String, Integer> getImportStocksCountByMonth() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT FORMAT(ImportDate, 'yyyy-MM') as ImportMonth, SUM(TotalAmount) as TotalImport "
                   + "FROM ImportStocks GROUP BY FORMAT(ImportDate, 'yyyy-MM') ORDER BY ImportMonth";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("ImportMonth"), rs.getInt("TotalImport"));
            }
        }
        return result;
    }

    // ❌ BỎ getStocksBySupplier()

    public Map<String, Integer> getTopImportedProducts() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT p.ProductName, SUM(idet.Quantity) as TotalQuantity "
                   + "FROM ImportStockDetails idet "
                   + "JOIN Products p ON idet.ProductID = p.ProductID "
                   + "GROUP BY p.ProductName ORDER BY TotalQuantity DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("ProductName"), rs.getInt("TotalQuantity"));
            }
        }
        return result;
    }

    private ImportStock extractImportStock(ResultSet rs) throws SQLException {
        return new ImportStock(
                rs.getInt("ImportID"),
                rs.getInt("StaffID"),
                rs.getInt("SupplierID"),
                rs.getTimestamp("ImportDate"),
                rs.getLong("TotalAmount"),
                rs.getInt("IsCompleted")
        );
    }

    public ArrayList<Product> getAllActiveProducts() {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE Deleted = 0 AND Status = 1 ORDER BY ProductName";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getBigDecimal("Price"));
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println("getAllActiveProducts: " + e.getMessage());
        }
        return list;
    }

    public int createImportStockWithDetails(ImportStock importStock, List<ImportStockDetail> details) {
        String insertImportStock = "INSERT INTO ImportStocks (StaffID, SupplierID, ImportDate, TotalAmount, IsCompleted) "
                                 + "VALUES (?, ?, GETDATE(), ?, 0)";
        String insertDetails = "INSERT INTO ImportStockDetails (ImportID, ProductID, Quantity, UnitPrice, QuantityLeft) "
                             + "VALUES (?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);
            int importId = -1;

            try (PreparedStatement ps = conn.prepareStatement(insertImportStock, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, importStock.getStaffId());
                ps.setInt(2, importStock.getSupplierId()); // ✅ vẫn lưu SupplierID
                ps.setLong(3, importStock.getTotalAmount());

                int affectedRows = ps.executeUpdate();
                if (affectedRows > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) importId = rs.getInt(1);
                }
            }

            if (importId > 0) {
                try (PreparedStatement ps = conn.prepareStatement(insertDetails)) {
                    for (ImportStockDetail detail : details) {
                        ps.setInt(1, importId);
                        ps.setInt(2, detail.getProduct().getProductId());
                        ps.setInt(3, detail.getQuantity());
                        ps.setLong(4, detail.getUnitPrice());
                        ps.setInt(5, detail.getQuantityLeft());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                conn.commit();
                return importId;
            } else {
                conn.rollback();
                return -1;
            }

        } catch (SQLException e) {
            try { conn.rollback(); } catch (SQLException ex) {
                System.out.println("Rollback error: " + ex.getMessage());
            }
            System.out.println("createImportStockWithDetails: " + e.getMessage());
            return -1;
        } finally {
            try { conn.setAutoCommit(true); } catch (SQLException e) {
                System.out.println("Reset auto commit error: " + e.getMessage());
            }
        }
    }

    // ❌ BỎ searchSuppliersByName()

    public ArrayList<Product> searchProductsByName(String name) {
        ArrayList<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProductName LIKE ? AND Deleted = 0 AND Status = 1 ORDER BY ProductName";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getBigDecimal("Price"));
                list.add(product);
            }
        } catch (SQLException e) {
            System.out.println("searchProductsByName: " + e.getMessage());
        }
        return list;
    }

    /**
     * ✅ Bỏ filter theo supplierId (vì không join supplier nữa)
     */
    public ArrayList<ImportStock> getImportHistoryFiltered(String from, String to) {
        ArrayList<ImportStock> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT i.*, f.FullName FROM ImportStocks i "
              + "JOIN Staff f ON i.StaffID = f.StaffID WHERE 1=1"
        );

        if (from != null && !from.isEmpty()) {
            sql.append(" AND i.ImportDate >= ?");
        }
        if (to != null && !to.isEmpty()) {
            sql.append(" AND i.ImportDate <= ?");
        }
        sql.append(" ORDER BY i.ImportDate DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (from != null && !from.isEmpty()) {
                ps.setString(idx++, from + " 00:00:00");
            }
            if (to != null && !to.isEmpty()) {
                ps.setString(idx++, to + " 23:59:59");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ImportStock imp = extractImportStock(rs);
                imp.setFullName(rs.getString("FullName"));
                list.add(imp);
            }
        } catch (SQLException e) {
            System.out.println("getImportHistoryFiltered: " + e.getMessage());
        }
        return list;
    }
}
