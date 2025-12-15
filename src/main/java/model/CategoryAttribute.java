/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Administrator
 */
public class CategoryAttribute {
    private int attributeID;
    private int groupID;
    private String attributeName;
    private String unit;      // nullable
    private byte dataType;    // 1=text, 2=number
    private boolean isDeleted;

    public CategoryAttribute() {
    }

    public CategoryAttribute(int attributeID, int groupID, String attributeName, String unit, byte dataType, boolean isDeleted) {
        this.attributeID = attributeID;
        this.groupID = groupID;
        this.attributeName = attributeName;
        this.unit = unit;
        this.dataType = dataType;
        this.isDeleted = isDeleted;
    }

    public int getAttributeID() {
        return attributeID;
    }

    public void setAttributeID(int attributeID) {
        this.attributeID = attributeID;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getAttributeName() {
        return attributeName;
    }

    public void setAttributeName(String attributeName) {
        this.attributeName = attributeName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public byte getDataType() {
        return dataType;
    }

    public void setDataType(byte dataType) {
        this.dataType = dataType;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
    
    
}
