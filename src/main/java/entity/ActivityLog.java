package entity;

import java.sql.Timestamp;


public class ActivityLog {


    private int id;

    private int userId;

    private String action;

    private String target;

    private Timestamp createdAt;


    private String username;



    public int getId() {
        return id;
    }


    public void setId(int id) {
        this.id=id;
    }



    public int getUserId() {
        return userId;
    }


    public void setUserId(int userId) {
        this.userId=userId;
    }



    public String getAction() {
        return action;
    }


    public void setAction(String action) {
        this.action=action;
    }



    public String getTarget() {
        return target;
    }


    public void setTarget(String target) {
        this.target=target;
    }



    public Timestamp getCreatedAt() {
        return createdAt;
    }


    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt=createdAt;
    }



    public String getUsername() {
        return username;
    }


    public void setUsername(String username) {
        this.username=username;
    }


}