/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class Address {

    private Integer AddressID;
    private Integer CustomerID;
    private String RecipientName;
    private String Phone;
    private String Province;
    private String District;
    private String Ward;
    private String DetailAddress;
    private Boolean IsDefault;
    private Boolean IsActive;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Address() {
    }

    public Address(Integer AddressID, Integer CustomerID, String RecipientName, String Phone, String Province, String District, String Ward, String DetailAddress, Boolean IsDefault, Boolean IsActive, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.AddressID = AddressID;
        this.CustomerID = CustomerID;
        this.RecipientName = RecipientName;
        this.Phone = Phone;
        this.Province = Province;
        this.District = District;
        this.Ward = Ward;
        this.DetailAddress = DetailAddress;
        this.IsDefault = IsDefault;
        this.IsActive = IsActive;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getAddressID() {
        return AddressID;
    }

    public void setAddressID(Integer AddressID) {
        this.AddressID = AddressID;
    }

    public Integer getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(Integer CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getRecipientName() {
        return RecipientName;
    }

    public void setRecipientName(String RecipientName) {
        this.RecipientName = RecipientName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getProvince() {
        return Province;
    }

    public void setProvince(String Province) {
        this.Province = Province;
    }

    public String getDistrict() {
        return District;
    }

    public void setDistrict(String District) {
        this.District = District;
    }

    public String getWard() {
        return Ward;
    }

    public void setWard(String Ward) {
        this.Ward = Ward;
    }

    public String getDetailAddress() {
        return DetailAddress;
    }

    public void setDetailAddress(String DetailAddress) {
        this.DetailAddress = DetailAddress;
    }

    public Boolean getIsDefault() {
        return IsDefault;
    }

    public void setIsDefault(Boolean IsDefault) {
        this.IsDefault = IsDefault;
    }

    public Boolean getIsActive() {
        return IsActive;
    }

    public void setIsActive(Boolean IsActive) {
        this.IsActive = IsActive;
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
