/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Administrator
 */
public class VariantAttribute {

    private Integer VariantAttributeID;
    private Integer ProductVariantID;
    private String AttributeName;
    private String AttributeValue;
    private String Unit;

    public VariantAttribute() {
    }

    public VariantAttribute(Integer VariantAttributeID, Integer ProductVariantID, String AttributeName, String AttributeValue, String Unit) {
        this.VariantAttributeID = VariantAttributeID;
        this.ProductVariantID = ProductVariantID;
        this.AttributeName = AttributeName;
        this.AttributeValue = AttributeValue;
        this.Unit = Unit;
    }

    public Integer getVariantAttributeID() {
        return VariantAttributeID;
    }

    public void setVariantAttributeID(Integer VariantAttributeID) {
        this.VariantAttributeID = VariantAttributeID;
    }

    public Integer getProductVariantID() {
        return ProductVariantID;
    }

    public void setProductVariantID(Integer ProductVariantID) {
        this.ProductVariantID = ProductVariantID;
    }

    public String getAttributeName() {
        return AttributeName;
    }

    public void setAttributeName(String AttributeName) {
        this.AttributeName = AttributeName;
    }

    public String getAttributeValue() {
        return AttributeValue;
    }

    public void setAttributeValue(String AttributeValue) {
        this.AttributeValue = AttributeValue;
    }

    public String getUnit() {
        return Unit;
    }

    public void setUnit(String Unit) {
        this.Unit = Unit;
    }
}
