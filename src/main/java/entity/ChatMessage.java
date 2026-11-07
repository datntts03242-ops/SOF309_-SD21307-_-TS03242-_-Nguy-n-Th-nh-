package entity;

import java.sql.Timestamp;

public class ChatMessage {

    public static final String SENDER_USER = "user";
    public static final String SENDER_GUEST = "guest";
    public static final String SENDER_ADMIN = "admin";

    private int id;
    private int conversationId;
    private String senderType;     // "user" | "guest" | "admin"
    private Integer senderUserId;  // null nếu senderType = guest
    private String content;
    private Timestamp sentAt;
    private boolean readByAdmin;
    private boolean readByUser;
    private boolean deleted; // true nếu admin đã thu hồi (xóa) tin nhắn này

    public ChatMessage() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getConversationId() {
        return conversationId;
    }

    public void setConversationId(int conversationId) {
        this.conversationId = conversationId;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    public Integer getSenderUserId() {
        return senderUserId;
    }

    public void setSenderUserId(Integer senderUserId) {
        this.senderUserId = senderUserId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getSentAt() {
        return sentAt;
    }

    public void setSentAt(Timestamp sentAt) {
        this.sentAt = sentAt;
    }

    public boolean isReadByAdmin() {
        return readByAdmin;
    }

    public void setReadByAdmin(boolean readByAdmin) {
        this.readByAdmin = readByAdmin;
    }

    public boolean isReadByUser() {
        return readByUser;
    }

    public void setReadByUser(boolean readByUser) {
        this.readByUser = readByUser;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}
