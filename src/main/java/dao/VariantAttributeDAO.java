package dao;

import model.VariantAttribute;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class VariantAttributeDAO {

    public List<VariantAttribute> getByVariantId(int productVariantId) throws Exception {
        List<VariantAttribute> list = new ArrayList<>();
        String sql = "SELECT VariantAttributeID, ProductVariantID, AttributeName, AttributeValue, Unit "
                   + "FROM VariantAttribute WHERE ProductVariantID=? ORDER BY VariantAttributeID DESC";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, productVariantId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VariantAttribute a = new VariantAttribute();
                    a.setVariantAttributeID(rs.getInt("VariantAttributeID"));
                    a.setProductVariantID(rs.getInt("ProductVariantID"));
                    a.setAttributeName(rs.getString("AttributeName"));
                    a.setAttributeValue(rs.getString("AttributeValue"));
                    a.setUnit(rs.getString("Unit")); // có thể null
                    list.add(a);
                }
            }
            return list;

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void insert(VariantAttribute a) throws Exception {
        String sql = "INSERT INTO VariantAttribute(ProductVariantID, AttributeName, AttributeValue, Unit) "
                   + "VALUES (?, ?, ?, ?)";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, a.getProductVariantID());
            ps.setString(2, a.getAttributeName());
            ps.setString(3, a.getAttributeValue());

            if (a.getUnit() != null && !a.getUnit().trim().isEmpty()) ps.setString(4, a.getUnit());
            else ps.setNull(4, Types.NVARCHAR);

            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    // Cách đơn giản khi update attributes: xóa hết rồi insert lại
    public void deleteByVariantId(int productVariantId) throws Exception {
        String sql = "DELETE FROM VariantAttribute WHERE ProductVariantID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, productVariantId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }

    public void delete(int variantAttributeId) throws Exception {
        String sql = "DELETE FROM VariantAttribute WHERE VariantAttributeID=?";

        DBContext db = new DBContext();
        try (PreparedStatement ps = db.conn.prepareStatement(sql)) {
            ps.setInt(1, variantAttributeId);
            ps.executeUpdate();

        } finally {
            if (db.conn != null) db.conn.close();
        }
    }
}
