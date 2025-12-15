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
public class Cart {
    private int customerID;
    private int variantID;
    private int quantity;
    private Timestamp addedAt;
    private Timestamp updatedAt;

    public Cart() {
    }

    public Cart(int customerID, int variantID, int quantity, Timestamp addedAt, Timestamp updatedAt) {
        this.customerID = customerID;
        this.variantID = variantID;
        this.quantity = quantity;
        this.addedAt = addedAt;
        this.updatedAt = updatedAt;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

   
}
