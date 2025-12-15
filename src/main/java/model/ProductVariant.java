/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class ProductVariant {
    private int variantID;
    private int productID;
    private String sku;
    private String variantName;
    private BigDecimal price;
    private int stockQuantity;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public ProductVariant() {
    }

    public ProductVariant(int variantID, int productID, String sku, String variantName, BigDecimal price, int stockQuantity, boolean isActive, Timestamp createdAt, Timestamp updatedAt) {
        this.variantID = variantID;
        this.productID = productID;
        this.sku = sku;
        this.variantName = variantName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getVariantName() {
        return variantName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    
    
    
}
