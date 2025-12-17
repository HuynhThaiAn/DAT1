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
public class Staff {

    private Integer StaffID;
    private String Email;
    private String PasswordHash;
    private String FullName;
    private String Phone;
    private LocalDate DateOfBirth;
    private Integer Gender;
    private Integer Role;
    private Boolean IsDeleted;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Staff() {
    }

    public Staff(Integer StaffID, String Email, String PasswordHash, String FullName, String Phone, LocalDate DateOfBirth, Integer Gender, Integer Role, Boolean IsDeleted, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.StaffID = StaffID;
        this.Email = Email;
        this.PasswordHash = PasswordHash;
        this.FullName = FullName;
        this.Phone = Phone;
        this.DateOfBirth = DateOfBirth;
        this.Gender = Gender;
        this.Role = Role;
        this.IsDeleted = IsDeleted;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }
    
    

    public Integer getStaffID() {
        return StaffID;
    }

    public void setStaffID(Integer StaffID) {
        this.StaffID = StaffID;
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

    public Integer getRole() {
        return Role;
    }

    public void setRole(Integer Role) {
        this.Role = Role;
    }

    public Boolean getIsDeleted() {
        return IsDeleted;
    }

    public void setIsDeleted(Boolean IsDeleted) {
        this.IsDeleted = IsDeleted;
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
