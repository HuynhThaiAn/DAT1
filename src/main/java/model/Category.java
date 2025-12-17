/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class Category {

    private Integer CategoryID;
    private String CategoryName;
    private String Description;
    private String ImgUrlLogo;
    private Boolean IsDeleted;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Category() {
    }

    public Category(Integer CategoryID, String CategoryName, String Description, String ImgUrlLogo, Boolean IsDeleted, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.CategoryID = CategoryID;
        this.CategoryName = CategoryName;
        this.Description = Description;
        this.ImgUrlLogo = ImgUrlLogo;
        this.IsDeleted = IsDeleted;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(Integer CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getImgUrlLogo() {
        return ImgUrlLogo;
    }

    public void setImgUrlLogo(String ImgUrlLogo) {
        this.ImgUrlLogo = ImgUrlLogo;
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
