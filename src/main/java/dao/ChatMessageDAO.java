package dao;

import entity.ChatMessage;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatMessageDAO {

    private ChatMessage mapRow(ResultSet rs) throws SQLException {
        ChatMessage m = new ChatMessage();
        m.setId(rs.getInt("id"));
        m.setConversationId(rs.getInt("conversation_id"));
        m.setSenderType(rs.getString("sender_type"));

        int senderUserId = rs.getInt("sender_user_id");
        m.setSenderUserId(rs.wasNull() ? null : senderUserId);

        m.setContent(rs.getString("content"));
        m.setSentAt(rs.getTimestamp("sent_at"));
        m.setReadByAdmin(rs.getBoolean("is_read_by_admin"));
        m.setReadByUser(rs.getBoolean("is_read_by_user"));

        try {
            m.setDeleted(rs.getBoolean("is_deleted"));
        } catch (SQLException ex) {
            // Cột is_deleted chưa được tạo trong DB (chưa chạy migration) -> coi như chưa xóa
            m.setDeleted(false);
        }

        return m;
    }

    // ================= INSERT =================

    /**
     * Thêm tin nhắn mới. Cờ đã đọc được set tự động dựa theo người gửi:
     * - user/guest gửi -> is_read_by_user = 1 (họ vừa gửi nên coi như đã đọc), is_read_by_admin = 0
     * - admin gửi      -> is_read_by_admin = 1, is_read_by_user = 0
     */
    public ChatMessage insertMessage(int conversationId, String senderType, Integer senderUserId, String content) {

        boolean isAdmin = ChatMessage.SENDER_ADMIN.equals(senderType);

        String sql = "INSERT INTO ChatMessages " +
                "(conversation_id, sender_type, sender_user_id, content, is_read_by_admin, is_read_by_user) " +
                "VALUES (?,?,?,?,?,?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, conversationId);
            ps.setString(2, senderType);

            if (senderUserId != null) {
                ps.setInt(3, senderUserId);
            } else {
                ps.setNull(3, Types.INTEGER);
            }

            ps.setString(4, content);
            ps.setBoolean(5, isAdmin);
            ps.setBoolean(6, !isAdmin);

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

    public ChatMessage findById(int id) {
        String sql = "SELECT * FROM ChatMessages WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= TRUY VẤN DANH SÁCH =================

    public List<ChatMessage> findByConversation(int conversationId) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM ChatMessages WHERE conversation_id=? ORDER BY id ASC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Dùng cho AJAX polling: chỉ lấy tin nhắn có id lớn hơn afterId */
    public List<ChatMessage> findNewMessages(int conversationId, int afterId) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM ChatMessages WHERE conversation_id=? AND id > ? ORDER BY id ASC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ps.setInt(2, afterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================= ĐÁNH DẤU ĐÃ ĐỌC =================

    public void markAllReadByAdmin(int conversationId) {
        String sql = "UPDATE ChatMessages SET is_read_by_admin=1 WHERE conversation_id=? AND is_read_by_admin=0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void markAllReadByUser(int conversationId) {
        String sql = "UPDATE ChatMessages SET is_read_by_user=1 WHERE conversation_id=? AND is_read_by_user=0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= XÓA TIN NHẮN (THU HỒI) =================

    /**
     * Thu hồi (xóa mềm) một tin nhắn: nội dung vẫn còn trong DB để đối chiếu,
     * nhưng is_deleted=1 nên cả admin lẫn user/guest đều chỉ thấy dòng
     * "Tin nhắn đã bị xóa" thay vì nội dung thật.
     * Trả về true nếu xóa thành công.
     */
    public boolean softDeleteMessage(int messageId) {
        String sql = "UPDATE ChatMessages SET is_deleted=1 WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, messageId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Xóa toàn bộ tin nhắn của 1 hội thoại - dùng khi admin xóa hẳn cuộc trò chuyện */
    public void deleteAllForConversation(int conversationId) {
        String sql = "DELETE FROM ChatMessages WHERE conversation_id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** Số tin nhắn admin gửi mà user/guest chưa đọc - dùng cho badge trên bong bóng chat */
    public int countUnreadForUser(int conversationId) {
        String sql = "SELECT COUNT(*) FROM ChatMessages WHERE conversation_id=? AND sender_type='admin' AND is_read_by_user=0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
