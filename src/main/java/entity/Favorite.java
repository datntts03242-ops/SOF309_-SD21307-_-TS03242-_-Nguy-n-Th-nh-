package entity;

import java.util.Date;

public class Favorite {

    private int userId;
    private int characterId;
    private Date createdAt;

    public Favorite() {}

    public Favorite(int userId, int characterId, Date createdAt) {
        this.userId = userId;
        this.characterId = characterId;
        this.createdAt = createdAt;
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}