/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Administrator
 */
public class ProductAttributeValue {
    private int productID;
    private int attributeID;
    private String value;

    public ProductAttributeValue() {}

    public ProductAttributeValue(int productID, int attributeID, String value) {
        this.productID = productID;
        this.attributeID = attributeID;
        this.value = value;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getAttributeID() {
        return attributeID;
    }

    public void setAttributeID(int attributeID) {
        this.attributeID = attributeID;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    
    
}
