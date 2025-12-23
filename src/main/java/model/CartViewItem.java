package model;

import java.math.BigDecimal;

public class CartViewItem {
    private Integer productID;
    private Integer productVariantID;
    private String productName;
    private String variantName;
    private String SKU;
    private BigDecimal price;
    private Integer stockQuantity;
    private Integer quantity;

    public Integer getProductID() { return productID; }
    public void setProductID(Integer productID) { this.productID = productID; }

    public Integer getProductVariantID() { return productVariantID; }
    public void setProductVariantID(Integer productVariantID) { this.productVariantID = productVariantID; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getVariantName() { return variantName; }
    public void setVariantName(String variantName) { this.variantName = variantName; }

    public String getSKU() { return SKU; }
    public void setSKU(String SKU) { this.SKU = SKU; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
}
