/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Administrator
 */
public class CategoryAttributeGroup {
    private int groupID;
    private int categoryID;
    private String groupName;
    private boolean isDeleted;

    public CategoryAttributeGroup() {}

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public CategoryAttributeGroup(int groupID, int categoryID, String groupName, boolean isDeleted) {
        this.groupID = groupID;
        this.categoryID = categoryID;
        this.groupName = groupName;
        this.isDeleted = isDeleted;
    }
    
    
}
