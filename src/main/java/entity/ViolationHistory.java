package entity;

import java.sql.Timestamp;

public class ViolationHistory {

    private int id;
    private int userId;
    private String commentContent;
    private String violationReason;
    private Timestamp createdAt;

    public ViolationHistory() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCommentContent() { return commentContent; }
    public void setCommentContent(String commentContent) { this.commentContent = commentContent; }

    public String getViolationReason() { return violationReason; }
    public void setViolationReason(String violationReason) { this.violationReason = violationReason; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}