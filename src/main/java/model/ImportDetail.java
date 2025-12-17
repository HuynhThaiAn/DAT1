/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author Administrator
 */
public class ImportDetail {

    private Integer ImportID;
    private Integer ProductVariantID;
    private BigDecimal UnitCost;
    private Integer Quantity;

    public ImportDetail() {
    }

    public ImportDetail(Integer ImportID, Integer ProductVariantID, BigDecimal UnitCost, Integer Quantity) {
        this.ImportID = ImportID;
        this.ProductVariantID = ProductVariantID;
        this.UnitCost = UnitCost;
        this.Quantity = Quantity;
    }

    public Integer getImportID() {
        return ImportID;
    }

    public void setImportID(Integer ImportID) {
        this.ImportID = ImportID;
    }

    public Integer getProductVariantID() {
        return ProductVariantID;
    }

    public void setProductVariantID(Integer ProductVariantID) {
        this.ProductVariantID = ProductVariantID;
    }

    public BigDecimal getUnitCost() {
        return UnitCost;
    }

    public void setUnitCost(BigDecimal UnitCost) {
        this.UnitCost = UnitCost;
    }

    public Integer getQuantity() {
        return Quantity;
    }

    public void setQuantity(Integer Quantity) {
        this.Quantity = Quantity;
    }
}
