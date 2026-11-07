package entity;

import java.util.Date;

public class Comment {

    private int id;
    private int userId;
    private int characterId;
    private String content;
    private int score;
    private Date createdAt;

    // Các field bổ sung để hiển thị (JOIN từ Users, Characters)
    private String username;
    private String characterName;

    public Comment() {}

    public Comment(int id, int userId, int characterId, String content, int score, Date createdAt) {
        super();
        this.id = id;
        this.userId = userId;
        this.characterId = characterId;
        this.content = content;
        this.score = score;
        this.createdAt = createdAt;
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

    public int getCharacterId() {
        return characterId;
    }

    public void setCharacterId(int characterId) {
        this.characterId = characterId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCharacterName() {
        return characterName;
    }

    public void setCharacterName(String characterName) {
        this.characterName = characterName;
    }

}