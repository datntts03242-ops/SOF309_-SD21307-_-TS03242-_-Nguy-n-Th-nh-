package dao;

import entity.ChatConversation;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatConversationDAO {

    // ================= MAP ROW =================
    private ChatConversation mapRow(ResultSet rs) throws SQLException {
        ChatConversation c = new ChatConversation();
        c.setId(rs.getInt("id"));

        int userId = rs.getInt("user_id");
        c.setUserId(rs.wasNull() ? null : userId);

        c.setGuestId(rs.getString("guest_id"));
        c.setGuestName(rs.getString("guest_name"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setLastMessageAt(rs.getTimestamp("last_message_at"));

        try {
            c.setArchived(rs.getBoolean("is_archived"));
        } catch (SQLException ex) {
            c.setArchived(false);
        }
        try {
            c.setBlocked(rs.getBoolean("is_blocked"));
        } catch (SQLException ex) {
            c.setBlocked(false);
        }

        return c;
    }

    // ================= FIND =================
    public ChatConversation findById(int id) {
        String sql =
            "SELECT c.*, u.fullname AS user_fullname, u.avatar AS user_avatar " +
            "FROM ChatConversations c LEFT JOIN Users u ON u.id = c.user_id " +
            "WHERE c.id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ChatConversation c = mapRow(rs);
                if (c.getUserId() != null) {
                    c.setDisplayName(rs.getString("user_fullname"));
                    c.setAvatar(rs.getString("user_avatar"));
                } else {
                    String guestName = c.getGuestName();
                    c.setDisplayName(
                        (guestName != null && !guestName.trim().isEmpty())
                            ? guestName
                            : "Khách ẩn danh #" + c.getId()
                    );
                }
                return c;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ChatConversation findByUserId(int userId) {
        String sql = "SELECT * FROM ChatConversations WHERE user_id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ChatConversation findByGuestId(String guestId) {
        String sql = "SELECT * FROM ChatConversations WHERE guest_id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, guestId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= GET OR CREATE =================
    public ChatConversation getOrCreateForUser(int userId) {
        ChatConversation existing = findByUserId(userId);
        if (existing != null) return existing;

        String sql = "INSERT INTO ChatConversations(user_id) VALUES (?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return findById(rs.getInt(1));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ChatConversation getOrCreateForGuest(String guestId) {
        ChatConversation existing = findByGuestId(guestId);
        if (existing != null) return existing;

        String sql = "INSERT INTO ChatConversations(guest_id) VALUES (?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, guestId);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return findById(rs.getInt(1));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= UPDATE =================
    public void updateGuestName(int conversationId, String guestName) {
        if (guestName == null || guestName.trim().isEmpty()) return;

        String sql = "UPDATE ChatConversations SET guest_name=? WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, guestName.trim());
            ps.setInt(2, conversationId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void touchLastMessageAt(int conversationId) {
        String sql = "UPDATE ChatConversations SET last_message_at=GETDATE() WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= ADMIN: DANH SÁCH HỘI THOẠI =================

    /** Danh sách hội thoại chưa lưu trữ (hộp thư chính) - mặc định cho trang admin/chat */
    public List<ChatConversation> findAllForAdmin() {
        return findAllForAdmin(false);
    }

    /**
     * @param archived false = hộp thư chính (chưa lưu trữ), true = danh sách đã lưu trữ
     */
    public List<ChatConversation> findAllForAdmin(boolean archived) {
        List<ChatConversation> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.user_id, c.guest_id, c.guest_name, c.created_at, c.last_message_at, " +
            "       c.is_archived, c.is_blocked, " +
            "       u.fullname AS user_fullname, u.avatar AS user_avatar, " +
            "       (SELECT COUNT(*) FROM ChatMessages m " +
            "         WHERE m.conversation_id = c.id AND m.sender_type <> 'admin' AND m.is_read_by_admin = 0) AS unread_count, " +
            "       (SELECT TOP 1 m2.content FROM ChatMessages m2 " +
            "         WHERE m2.conversation_id = c.id AND m2.is_deleted = 0 ORDER BY m2.id DESC) AS last_content " +
            "FROM ChatConversations c " +
            "LEFT JOIN Users u ON u.id = c.user_id " +
            "WHERE c.is_archived = ? " +
            "ORDER BY c.last_message_at DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, archived);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ChatConversation c = mapRow(rs);

                if (c.getUserId() != null) {
                    c.setDisplayName(rs.getString("user_fullname"));
                    c.setAvatar(rs.getString("user_avatar"));
                } else {
                    String guestName = c.getGuestName();
                    c.setDisplayName(
                        (guestName != null && !guestName.trim().isEmpty())
                            ? guestName
                            : "Khách ẩn danh #" + c.getId()
                    );
                }

                c.setLastMessageContent(rs.getString("last_content"));
                c.setUnreadCount(rs.getInt("unread_count"));

                list.add(c);
            }

        } catch (SQLException e) {
            // Cột is_archived/is_blocked chưa tồn tại trong ChatConversations vì
            // sql/chat_moderation_migration.sql chưa được chạy trên DB thật.
            // -> Không để admin thấy hộp thư trống oan: dùng truy vấn dự phòng
            //    không phụ thuộc 2 cột này, để tin nhắn của user/guest vẫn hiện ra.
            System.err.println("[ChatConversationDAO] Thiếu cột is_archived/is_blocked trong bảng "
                + "ChatConversations. HÃY CHẠY sql/chat_moderation_migration.sql trên database. "
                + "Đang dùng truy vấn dự phòng tạm thời. Lỗi gốc: " + e.getMessage());

            if (archived) {
                // Chưa có cột is_archived -> coi như chưa từng lưu trữ hội thoại nào
                return list;
            }
            return findAllForAdminFallback();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Truy vấn dự phòng dùng khi ChatConversations CHƯA có cột is_archived/is_blocked
     * (tức là chưa chạy sql/chat_moderation_migration.sql). Trả về toàn bộ hội thoại,
     * coi như chưa lưu trữ và chưa bị chặn, để admin ít nhất vẫn nhận được tin nhắn.
     * Xóa hàm này sau khi đã chắc chắn migration đã chạy trên mọi môi trường.
     */
    private List<ChatConversation> findAllForAdminFallback() {
        List<ChatConversation> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.user_id, c.guest_id, c.guest_name, c.created_at, c.last_message_at, " +
            "       u.fullname AS user_fullname, u.avatar AS user_avatar, " +
            "       (SELECT COUNT(*) FROM ChatMessages m " +
            "         WHERE m.conversation_id = c.id AND m.sender_type <> 'admin' AND m.is_read_by_admin = 0) AS unread_count, " +
            "       (SELECT TOP 1 m2.content FROM ChatMessages m2 " +
            "         WHERE m2.conversation_id = c.id ORDER BY m2.id DESC) AS last_content " +
            "FROM ChatConversations c " +
            "LEFT JOIN Users u ON u.id = c.user_id " +
            "ORDER BY c.last_message_at DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ChatConversation c = new ChatConversation();
                c.setId(rs.getInt("id"));

                int userId = rs.getInt("user_id");
                c.setUserId(rs.wasNull() ? null : userId);

                c.setGuestId(rs.getString("guest_id"));
                c.setGuestName(rs.getString("guest_name"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setLastMessageAt(rs.getTimestamp("last_message_at"));
                c.setArchived(false);
                c.setBlocked(false);

                if (c.getUserId() != null) {
                    c.setDisplayName(rs.getString("user_fullname"));
                    c.setAvatar(rs.getString("user_avatar"));
                } else {
                    String guestName = c.getGuestName();
                    c.setDisplayName(
                        (guestName != null && !guestName.trim().isEmpty())
                            ? guestName
                            : "Khách ẩn danh #" + c.getId()
                    );
                }

                c.setLastMessageContent(rs.getString("last_content"));
                c.setUnreadCount(rs.getInt("unread_count"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= LƯU TRỮ / CHẶN / XÓA HỘI THOẠI =================

    /** Lưu trữ hoặc bỏ lưu trữ 1 hội thoại (chuyển giữa hộp thư chính và tab "Đã lưu trữ") */
    public boolean setArchived(int conversationId, boolean archived) {
        String sql = "UPDATE ChatConversations SET is_archived=? WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, archived);
            ps.setInt(2, conversationId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Chặn hoặc bỏ chặn: người bị chặn vẫn xem được lịch sử chat nhưng không gửi được tin nhắn mới */
    public boolean setBlocked(int conversationId, boolean blocked) {
        String sql = "UPDATE ChatConversations SET is_blocked=? WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, blocked);
            ps.setInt(2, conversationId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa hẳn 1 hội thoại (và toàn bộ tin nhắn của nó) khỏi hệ thống.
     * Dùng khi admin bấm "Xóa người dùng vừa chat" - chỉ xóa thread chat,
     * KHÔNG đụng tới tài khoản User (nếu có) trong bảng Users.
     */
    public boolean deleteConversation(int conversationId) {
        String sql = "DELETE FROM ChatConversations WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countTotalUnreadForAdmin() {
        String sql = "SELECT COUNT(*) FROM ChatMessages WHERE sender_type <> 'admin' AND is_read_by_admin = 0";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
