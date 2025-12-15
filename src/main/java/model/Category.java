/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Administrator
 */
public class Category {
    private int categoryID;
    private String categoryName;
    private String description;
    private String imgUrlLogo;
    private boolean isDeleted;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Category() {}

    public Category(int categoryID, String categoryName, String description, String imgUrlLogo, boolean isDeleted, Timestamp createdAt, Timestamp updatedAt) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.description = description;
        this.imgUrlLogo = imgUrlLogo;
        this.isDeleted = isDeleted;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgUrlLogo() {
        return imgUrlLogo;
    }

    public void setImgUrlLogo(String imgUrlLogo) {
        this.imgUrlLogo = imgUrlLogo;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
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
