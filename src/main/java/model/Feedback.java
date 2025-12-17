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
public class Feedback {

    private Integer FeedbackID;
    private Integer ProductID;
    private Integer CustomerID;
    private Integer Rating;
    private String Comment;
    private Boolean IsVisible;
    private LocalDateTime CreatedAt;
    private LocalDateTime UpdatedAt;

    public Feedback() {
    }

    public Feedback(Integer FeedbackID, Integer ProductID, Integer CustomerID, Integer Rating, String Comment, Boolean IsVisible, LocalDateTime CreatedAt, LocalDateTime UpdatedAt) {
        this.FeedbackID = FeedbackID;
        this.ProductID = ProductID;
        this.CustomerID = CustomerID;
        this.Rating = Rating;
        this.Comment = Comment;
        this.IsVisible = IsVisible;
        this.CreatedAt = CreatedAt;
        this.UpdatedAt = UpdatedAt;
    }

    public Integer getFeedbackID() {
        return FeedbackID;
    }

    public void setFeedbackID(Integer FeedbackID) {
        this.FeedbackID = FeedbackID;
    }

    public Integer getProductID() {
        return ProductID;
    }

    public void setProductID(Integer ProductID) {
        this.ProductID = ProductID;
    }

    public Integer getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(Integer CustomerID) {
        this.CustomerID = CustomerID;
    }

    public Integer getRating() {
        return Rating;
    }

    public void setRating(Integer Rating) {
        this.Rating = Rating;
    }

    public String getComment() {
        return Comment;
    }

    public void setComment(String Comment) {
        this.Comment = Comment;
    }

    public Boolean getIsVisible() {
        return IsVisible;
    }

    public void setIsVisible(Boolean IsVisible) {
        this.IsVisible = IsVisible;
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


