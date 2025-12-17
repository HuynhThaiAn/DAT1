/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Administrator
 */
public class Customer {

    private Integer CustomerID;
    private String Email;
    private String PasswordHash;
    private String FullName;
    private String Phone;
    private LocalDate DateOfBirth;
    private Integer Gender;
    private String AvatarUrl;
    private Boolean IsBlocked;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Customer() {
    }

    public Customer(Integer CustomerID, String Email, String PasswordHash, String FullName, String Phone, LocalDate DateOfBirth, Integer Gender, String AvatarUrl, Boolean IsBlocked, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.CustomerID = CustomerID;
        this.Email = Email;
        this.PasswordHash = PasswordHash;
        this.FullName = FullName;
        this.Phone = Phone;
        this.DateOfBirth = DateOfBirth;
        this.Gender = Gender;
        this.AvatarUrl = AvatarUrl;
        this.IsBlocked = IsBlocked;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(Integer CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPasswordHash() {
        return PasswordHash;
    }

    public void setPasswordHash(String PasswordHash) {
        this.PasswordHash = PasswordHash;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public LocalDate getDateOfBirth() {
        return DateOfBirth;
    }

    public void setDateOfBirth(LocalDate DateOfBirth) {
        this.DateOfBirth = DateOfBirth;
    }

    public Integer getGender() {
        return Gender;
    }

    public void setGender(Integer Gender) {
        this.Gender = Gender;
    }

    public String getAvatarUrl() {
        return AvatarUrl;
    }

    public void setAvatarUrl(String AvatarUrl) {
        this.AvatarUrl = AvatarUrl;
    }

    public Boolean getIsBlocked() {
        return IsBlocked;
    }

    public void setIsBlocked(Boolean IsBlocked) {
        this.IsBlocked = IsBlocked;
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
