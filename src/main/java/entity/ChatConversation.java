package entity;

import java.sql.Timestamp;

public class ChatConversation {

    private int id;
    private Integer userId;      // null nếu là khách
    private String guestId;      // null nếu là user đã đăng nhập
    private String guestName;    // tên khách tự nhập (có thể null)
    private Timestamp createdAt;
    private Timestamp lastMessageAt;

    // ==== Các field bổ sung để hiển thị (JOIN từ Users + tính toán) ====
    private String displayName;      // fullname (user) hoặc guestName/"Khách ẩn danh #id" (guest)
    private String avatar;           // avatar user, null nếu là khách
    private String lastMessageContent;
    private int unreadCount;         // số tin nhắn user/guest gửi mà admin CHƯA đọc
    private boolean archived;        // true nếu admin đã lưu trữ hội thoại này
    private boolean blocked;         // true nếu admin đã chặn người này gửi tin nhắn

    public ChatConversation() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getGuestId() {
        return guestId;
    }

    public void setGuestId(String guestId) {
        this.guestId = guestId;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getLastMessageAt() {
        return lastMessageAt;
    }

    public void setLastMessageAt(Timestamp lastMessageAt) {
        this.lastMessageAt = lastMessageAt;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getLastMessageContent() {
        return lastMessageContent;
    }

    public void setLastMessageContent(String lastMessageContent) {
        this.lastMessageContent = lastMessageContent;
    }

    public int getUnreadCount() {
        return unreadCount;
    }

    public void setUnreadCount(int unreadCount) {
        this.unreadCount = unreadCount;
    }

    public boolean isGuest() {
        return guestId != null;
    }

    public boolean isArchived() {
        return archived;
    }

    public void setArchived(boolean archived) {
        this.archived = archived;
    }

    public boolean isBlocked() {
        return blocked;
    }

    public void setBlocked(boolean blocked) {
        this.blocked = blocked;
    }
}
