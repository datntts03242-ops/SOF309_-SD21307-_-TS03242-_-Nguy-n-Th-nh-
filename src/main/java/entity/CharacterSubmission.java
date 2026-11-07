package entity;
import java.util.Date;

public class CharacterSubmission {
	private int id;
    private int userId;

    private String name;
    private String dynasty;
    private Integer dynastyId;

    private String description;
    private String biography;
    private String achievement;

    private String birthPlace;
    private String historicalSite;

    private String image;
    private String youtubeLink;

    private Integer timelineOrder;

    private String status;

    private Date createdAt;
    private Date reviewedAt;

    private Integer reviewedBy;

    private String rejectReason;
    private String submitterUsername; // JOIN từ Users table

    public CharacterSubmission() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDynasty() {
        return dynasty;
    }

    public void setDynasty(String dynasty) {
        this.dynasty = dynasty;
    }

    public Integer getDynastyId() {
        return dynastyId;
    }

    public void setDynastyId(Integer dynastyId) {
        this.dynastyId = dynastyId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    public String getAchievement() {
        return achievement;
    }

    public void setAchievement(String achievement) {
        this.achievement = achievement;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    public String getHistoricalSite() {
        return historicalSite;
    }

    public void setHistoricalSite(String historicalSite) {
        this.historicalSite = historicalSite;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getYoutubeLink() {
        return youtubeLink;
    }

    public void setYoutubeLink(String youtubeLink) {
        this.youtubeLink = youtubeLink;
    }

    public Integer getTimelineOrder() {
        return timelineOrder;
    }

    public void setTimelineOrder(Integer timelineOrder) {
        this.timelineOrder = timelineOrder;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
public Date getReviewedAt() {
        return reviewedAt;
    }

    public void setReviewedAt(Date reviewedAt) {
        this.reviewedAt = reviewedAt;
    }

    public Integer getReviewedBy() {
        return reviewedBy;
    }

    public void setReviewedBy(Integer reviewedBy) {
        this.reviewedBy = reviewedBy;
    }

    public String getRejectReason() { return rejectReason; }
    public void setRejectReason(String rejectReason) { this.rejectReason = rejectReason; }

    public String getSubmitterUsername() { return submitterUsername; }
    public void setSubmitterUsername(String submitterUsername) { this.submitterUsername = submitterUsername; }
}