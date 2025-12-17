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

    private Integer ImportID;
    private Integer StaffID;
    private String SupplierName;
    private BigDecimal TotalCost;
    private Integer Status;
    private String Note;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Import() {
    }

    public Import(Integer ImportID, Integer StaffID, String SupplierName, BigDecimal TotalCost, Integer Status, String Note, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.ImportID = ImportID;
        this.StaffID = StaffID;
        this.SupplierName = SupplierName;
        this.TotalCost = TotalCost;
        this.Status = Status;
        this.Note = Note;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }

    public Integer getImportID() {
        return ImportID;
    }

    public void setImportID(Integer ImportID) {
        this.ImportID = ImportID;
    }

    public Integer getStaffID() {
        return StaffID;
    }

    public void setStaffID(Integer StaffID) {
        this.StaffID = StaffID;
    }

    public String getSupplierName() {
        return SupplierName;
    }

    public void setSupplierName(String SupplierName) {
        this.SupplierName = SupplierName;
    }

    public BigDecimal getTotalCost() {
        return TotalCost;
    }

    public void setTotalCost(BigDecimal TotalCost) {
        this.TotalCost = TotalCost;
    }

    public Integer getStatus() {
        return Status;
    }

    public void setStatus(Integer Status) {
        this.Status = Status;
    }

    public String getNote() {
        return Note;
    }

    public void setNote(String Note) {
        this.Note = Note;
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


