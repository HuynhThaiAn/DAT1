/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

public class FeedbackReply {

    private Integer ReplyID;
    private Integer FeedbackID;
    private Integer StaffID;
    private String Content;
    private Boolean IsPublic;
    private LocalDateTime CreatedAt;

    public FeedbackReply() {
    }

    public FeedbackReply(Integer ReplyID, Integer FeedbackID, Integer StaffID, String Content, Boolean IsPublic, LocalDateTime CreatedAt) {
        this.ReplyID = ReplyID;
        this.FeedbackID = FeedbackID;
        this.StaffID = StaffID;
        this.Content = Content;
        this.IsPublic = IsPublic;
        this.CreatedAt = CreatedAt;
    }

    public Integer getReplyID() {
        return ReplyID;
    }

    public void setReplyID(Integer ReplyID) {
        this.ReplyID = ReplyID;
    }

    public Integer getFeedbackID() {
        return FeedbackID;
    }

    public void setFeedbackID(Integer FeedbackID) {
        this.FeedbackID = FeedbackID;
    }

    public Integer getStaffID() {
        return StaffID;
    }

    public void setStaffID(Integer StaffID) {
        this.StaffID = StaffID;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public Boolean getIsPublic() {
        return IsPublic;
    }

    public void setIsPublic(Boolean IsPublic) {
        this.IsPublic = IsPublic;
    }

    public LocalDateTime getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(LocalDateTime CreatedAt) {
        this.CreatedAt = CreatedAt;
    }
}
