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
public class Import {
    private int importID;
    private int staffID;
    private String supplierName;
    private BigDecimal totalCost;
    private byte status;
    private String note;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Import() {}

    public Import(int importID, int staffID, String supplierName, BigDecimal totalCost, byte status, String note, Timestamp createdAt, Timestamp updatedAt) {
        this.importID = importID;
        this.staffID = staffID;
        this.supplierName = supplierName;
        this.totalCost = totalCost;
        this.status = status;
        this.note = note;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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
