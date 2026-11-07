package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "fullname")
    private String fullname;

    @Column(name = "role")
    private String role;

    @Column(name = "avatar")
    private String avatar;
    
    @Column(name = "active")
    private boolean  active;

    @Column(name = "warning_count")
    private int warningCount;

    @Column(name = "banned_at")
    private java.sql.Timestamp bannedAt;
    
    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

	public boolean  getActive() {
		return active;
	}

	public void setActive(boolean  active) {
		this.active = active;
	}
	
	public int getWarningCount() {
        return warningCount;
    }

    public void setWarningCount(int warningCount) {
        this.warningCount = warningCount;
    }

    public java.sql.Timestamp getBannedAt() {
        return bannedAt;
    }

    public void setBannedAt(java.sql.Timestamp bannedAt) {
        this.bannedAt = bannedAt;
    }
    
    
}