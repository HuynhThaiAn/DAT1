/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class ProductVariant {

    private Integer ProductVariantID;
    private Integer ProductID;
    private String SKU;
    private String VariantName;
    private BigDecimal Price;
    private Integer StockQuantity;
    private Boolean IsActive;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public ProductVariant() {
    }

    public ProductVariant(Integer ProductVariantID, Integer ProductID, String SKU, String VariantName, BigDecimal Price, Integer StockQuantity, Boolean IsActive, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.ProductVariantID = ProductVariantID;
        this.ProductID = ProductID;
        this.SKU = SKU;
        this.VariantName = VariantName;
        this.Price = Price;
        this.StockQuantity = StockQuantity;
        this.IsActive = IsActive;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getProductVariantID() {
        return ProductVariantID;
    }

    public void setProductVariantID(Integer ProductVariantID) {
        this.ProductVariantID = ProductVariantID;
    }

    public Integer getProductID() {
        return ProductID;
    }

    public void setProductID(Integer ProductID) {
        this.ProductID = ProductID;
    }

    public String getSKU() {
        return SKU;
    }

    public void setSKU(String SKU) {
        this.SKU = SKU;
    }

    public String getVariantName() {
        return VariantName;
    }

    public void setVariantName(String VariantName) {
        this.VariantName = VariantName;
    }

    public BigDecimal getPrice() {
        return Price;
    }

    public void setPrice(BigDecimal Price) {
        this.Price = Price;
    }

    public Integer getStockQuantity() {
        return StockQuantity;
    }

    public void setStockQuantity(Integer StockQuantity) {
        this.StockQuantity = StockQuantity;
    }

    public Boolean getIsActive() {
        return IsActive;
    }

    public void setIsActive(Boolean IsActive) {
        this.IsActive = IsActive;
    }

    public LocalDateTime getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(LocalDateTime CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return UpdatedAt;
    }

    public void setUpdatedAt(LocalDateTime UpdatedAt) {
        this.UpdatedAt = UpdatedAt;
    }
}
