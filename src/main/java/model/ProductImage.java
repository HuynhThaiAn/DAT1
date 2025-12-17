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
public class ProductImage {

    private Integer ImageID;
    private Integer ProductID;
    private String ImageUrl;
    private Boolean IsMain;
    private LocalDateTime CreatedAt;

    public ProductImage() {
    }

    public ProductImage(Integer ImageID, Integer ProductID, String ImageUrl, Boolean IsMain, LocalDateTime CreatedAt) {
        this.ImageID = ImageID;
        this.ProductID = ProductID;
        this.ImageUrl = ImageUrl;
        this.IsMain = IsMain;
        this.CreatedAt = CreatedAt;
    }
    
    

    public Integer getImageID() {
        return ImageID;
    }

    public void setImageID(Integer ImageID) {
        this.ImageID = ImageID;
    }

    public Integer getProductID() {
        return ProductID;
    }

    public void setProductID(Integer ProductID) {
        this.ProductID = ProductID;
    }

    public String getImageUrl() {
        return ImageUrl;
    }

    public void setImageUrl(String ImageUrl) {
        this.ImageUrl = ImageUrl;
    }

    public Boolean getIsMain() {
        return IsMain;
    }

    public void setIsMain(Boolean IsMain) {
        this.IsMain = IsMain;
    }

    public LocalDateTime getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(LocalDateTime CreatedAt) {
        this.CreatedAt = CreatedAt;
    }
}

