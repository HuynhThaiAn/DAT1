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
public class Cart {

    private Integer CustomerID;
    private Integer ProductVariantID;
    private Integer Quantity;
    private LocalDateTime AddedAt;
    private LocalDateTime UpdatedAt;

    public Cart() {
    }

    public Cart(Integer CustomerID, Integer ProductVariantID, Integer Quantity, LocalDateTime AddedAt, LocalDateTime UpdatedAt) {
        this.CustomerID = CustomerID;
        this.ProductVariantID = ProductVariantID;
        this.Quantity = Quantity;
        this.AddedAt = AddedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(Integer CustomerID) {
        this.CustomerID = CustomerID;
    }

    public Integer getProductVariantID() {
        return ProductVariantID;
    }

    public void setProductVariantID(Integer ProductVariantID) {
        this.ProductVariantID = ProductVariantID;
    }

    public Integer getQuantity() {
        return Quantity;
    }

    public void setQuantity(Integer Quantity) {
        this.Quantity = Quantity;
    }

    public LocalDateTime getAddedAt() {
        return AddedAt;
    }

    public void setAddedAt(LocalDateTime AddedAt) {
        this.AddedAt = AddedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return UpdatedAt;
    }

    public void setUpdatedAt(LocalDateTime UpdatedAt) {
        this.UpdatedAt = UpdatedAt;
    }
}
