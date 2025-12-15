/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Administrator
 */
public class CategoryDetailsGroup {
    private int categoryDetailsGroupID;
    private int categoryID;
    private String nameCategoryDetailsGroup;

    public CategoryDetailsGroup() {
    }

    public CategoryDetailsGroup(int categoryDetailsGroupID, int categoryID, String nameCategoryDetailsGroup) {
        this.categoryDetailsGroupID = categoryDetailsGroupID;
        this.categoryID = categoryID;
        this.nameCategoryDetailsGroup = nameCategoryDetailsGroup;
    }

    public int getCategoryDetailsGroupID() {
        return categoryDetailsGroupID;
    }

    public void setCategoryDetailsGroupID(int categoryDetailsGroupID) {
        this.categoryDetailsGroupID = categoryDetailsGroupID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getNameCategoryDetailsGroup() {
        return nameCategoryDetailsGroup;
    }

    public void setNameCategoryDetailsGroup(String nameCategoryDetailsGroup) {
        this.nameCategoryDetailsGroup = nameCategoryDetailsGroup;
    }
    
    
}
