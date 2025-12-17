/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class Product {

    private Integer ProductID;
    private Integer CategoryID;
    private Integer BrandID;
    private String ProductName;
    private String Description;
    private Boolean IsDeleted;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Product() {
    }

    public Product(Integer ProductID, Integer CategoryID, Integer BrandID, String ProductName, String Description, Boolean IsDeleted, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.ProductID = ProductID;
        this.CategoryID = CategoryID;
        this.BrandID = BrandID;
        this.ProductName = ProductName;
        this.Description = Description;
        this.IsDeleted = IsDeleted;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getProductID() {
        return ProductID;
    }

    public void setProductID(Integer ProductID) {
        this.ProductID = ProductID;
    }

    public Integer getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(Integer CategoryID) {
        this.CategoryID = CategoryID;
    }

    public Integer getBrandID() {
        return BrandID;
    }

    public void setBrandID(Integer BrandID) {
        this.BrandID = BrandID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public Boolean getIsDeleted() {
        return IsDeleted;
    }

    public void setIsDeleted(Boolean IsDeleted) {
        this.IsDeleted = IsDeleted;
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
