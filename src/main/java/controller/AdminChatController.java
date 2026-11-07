package controller;

import dao.ChatConversationDAO;
import dao.ChatMessageDAO;
import entity.ChatConversation;
import entity.ChatMessage;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.SessionUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Servlet quản lý chat phía Admin.
 * Route "/admin/chat" đã được AdminFilter + LoginFilter bảo vệ (chỉ admin
 * đã đăng nhập mới vào được), nhưng vẫn kiểm tra lại quyền admin ở đây
 * để phòng thủ theo chiều sâu (defense in depth).
 */
@WebServlet("/admin/chat")
public class AdminChatController extends HttpServlet {

    private final ChatConversationDAO conversationDAO = new ChatConversationDAO();
    private final ChatMessageDAO messageDAO = new ChatMessageDAO();

    private String formatTime(java.sql.Timestamp ts) {
        if (ts == null) return "";
        return new SimpleDateFormat("HH:mm dd/MM").format(ts);
    }

    private String formatShortTime(java.sql.Timestamp ts) {
        if (ts == null) return "";
        return new SimpleDateFormat("HH:mm dd/MM").format(ts);
    }

    private static final String DELETED_PLACEHOLDER = "Tin nhắn đã bị xóa";

    private JSONArray buildMessagesJson(List<ChatMessage> messages) {
        JSONArray arr = new JSONArray();
        for (ChatMessage m : messages) {
            JSONObject o = new JSONObject();
            o.put("id", m.getId());
            o.put("senderType", m.getSenderType());
            o.put("fromAdmin", ChatMessage.SENDER_ADMIN.equals(m.getSenderType()));
            o.put("deleted", m.isDeleted());
            o.put("content", m.isDeleted() ? DELETED_PLACEHOLDER : m.getContent());
            o.put("sentAt", formatTime(m.getSentAt()));
            arr.put(o);
        }
        return arr;
    }

    private JSONArray buildConversationsJson(List<ChatConversation> list) {
        JSONArray arr = new JSONArray();
        for (ChatConversation c : list) {
            JSONObject o = new JSONObject();
            o.put("id", c.getId());
            o.put("displayName", c.getDisplayName());
            o.put("avatar", c.getAvatar() == null ? JSONObject.NULL : c.getAvatar());
            o.put("isGuest", c.isGuest());
            o.put("isArchived", c.isArchived());
            o.put("isBlocked", c.isBlocked());
            o.put("lastMessageContent", c.getLastMessageContent() == null ? "" : c.getLastMessageContent());
            o.put("lastMessageAt", formatShortTime(c.getLastMessageAt()));
            o.put("unreadCount", c.getUnreadCount());
            arr.put(o);
        }
        return arr;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Kiểm tra quyền admin (phòng thủ theo chiều sâu, dù AdminFilter đã chặn)
        if (!SessionUtil.isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "page";

        switch (action) {

            case "conversations": {
                resp.setContentType("application/json;charset=UTF-8");
                boolean archivedScope = "archived".equals(req.getParameter("scope"));
                List<ChatConversation> list = conversationDAO.findAllForAdmin(archivedScope);
                JSONObject out = new JSONObject();
                out.put("conversations", buildConversationsJson(list));
                resp.getWriter().write(out.toString());
                return;
            }

            case "messages": {
                resp.setContentType("application/json;charset=UTF-8");
                int conversationId = parseIntSafe(req.getParameter("conversationId"), -1);
                JSONObject out = new JSONObject();

                ChatConversation conv = conversationDAO.findById(conversationId);
                if (conv == null) {
                    out.put("error", "Không tìm thấy cuộc trò chuyện");
                    resp.getWriter().write(out.toString());
                    return;
                }

                List<ChatMessage> history = messageDAO.findByConversation(conversationId);
                messageDAO.markAllReadByAdmin(conversationId);

                out.put("conversationId", conversationId);
                out.put("displayName", conv.getDisplayName() != null ? conv.getDisplayName()
                        : (conv.isGuest() ? "Khách ẩn danh #" + conv.getId() : ""));
                out.put("isArchived", conv.isArchived());
                out.put("isBlocked", conv.isBlocked());
                out.put("messages", buildMessagesJson(history));
                resp.getWriter().write(out.toString());
                return;
            }

            case "poll": {
                resp.setContentType("application/json;charset=UTF-8");
                int conversationId = parseIntSafe(req.getParameter("conversationId"), -1);
                int afterId = parseIntSafe(req.getParameter("afterId"), 0);
                JSONObject out = new JSONObject();

                ChatConversation conv = conversationDAO.findById(conversationId);
                if (conv == null) {
                    out.put("error", "Không tìm thấy cuộc trò chuyện");
                    resp.getWriter().write(out.toString());
                    return;
                }

                List<ChatMessage> newMsgs = messageDAO.findNewMessages(conversationId, afterId);
                messageDAO.markAllReadByAdmin(conversationId);

                out.put("conversationId", conversationId);
                out.put("messages", buildMessagesJson(newMsgs));
                resp.getWriter().write(out.toString());
                return;
            }

            case "unreadCount": {
                resp.setContentType("application/json;charset=UTF-8");
                JSONObject out = new JSONObject();
                out.put("unread", conversationDAO.countTotalUnreadForAdmin());
                resp.getWriter().write(out.toString());
                return;
            }

            case "page":
            default: {
                List<ChatConversation> list = conversationDAO.findAllForAdmin();
                req.setAttribute("conversations", list);
                req.getRequestDispatcher("/views/admin/chat/list.jsp").forward(req, resp);
                return;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        JSONObject out = new JSONObject();

        if (!SessionUtil.isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");

        switch (action == null ? "" : action) {
            case "archive":
            case "unarchive": {
                int conversationId = parseIntSafe(req.getParameter("conversationId"), -1);
                boolean ok = conversationDAO.setArchived(conversationId, "archive".equals(action));
                if (!ok) out.put("error", "Không thể cập nhật trạng thái lưu trữ");
                else out.put("success", true);
                resp.getWriter().write(out.toString());
                return;
            }
            case "block":
            case "unblock": {
                int conversationId = parseIntSafe(req.getParameter("conversationId"), -1);
                boolean ok = conversationDAO.setBlocked(conversationId, "block".equals(action));
                if (!ok) out.put("error", "Không thể cập nhật trạng thái chặn");
                else out.put("success", true);
                resp.getWriter().write(out.toString());
                return;
            }
            case "deleteMessage": {
                int messageId = parseIntSafe(req.getParameter("messageId"), -1);
                boolean ok = messageDAO.softDeleteMessage(messageId);
                if (!ok) out.put("error", "Không thể xóa tin nhắn");
                else out.put("success", true);
                resp.getWriter().write(out.toString());
                return;
            }
            case "deleteConversation": {
                int conversationId = parseIntSafe(req.getParameter("conversationId"), -1);
                ChatConversation convToDelete = conversationDAO.findById(conversationId);
                if (convToDelete == null) {
                    out.put("error", "Không tìm thấy cuộc trò chuyện");
                    resp.getWriter().write(out.toString());
                    return;
                }
                // Xóa tin nhắn trước để tránh vướng ràng buộc khóa ngoại, sau đó xóa hội thoại
                messageDAO.deleteAllForConversation(conversationId);
                boolean ok = conversationDAO.deleteConversation(conversationId);
                if (!ok) out.put("error", "Không thể xóa cuộc trò chuyện");
                else out.put("success", true);
                resp.getWriter().write(out.toString());
                return;
            }
            case "send":
                break; // xử lý bên dưới
            default:
                out.put("error", "Hành động không hợp lệ");
                resp.getWriter().write(out.toString());
                return;
        }

        int conversationId = parseIntSafe(req.getParameter("conversationId"), -1);
        String content = req.getParameter("content");

        if (content == null || content.trim().isEmpty()) {
            out.put("error", "Nội dung tin nhắn không được để trống");
            resp.getWriter().write(out.toString());
            return;
        }

        content = content.trim();
        if (content.length() > 1000) {
            content = content.substring(0, 1000);
        }

        ChatConversation conv = conversationDAO.findById(conversationId);
        if (conv == null) {
            out.put("error", "Không tìm thấy cuộc trò chuyện");
            resp.getWriter().write(out.toString());
            return;
        }

        // sender_id của admin LUÔN lấy từ session, không nhận từ client
        User admin = SessionUtil.getUser(req);

        ChatMessage saved = messageDAO.insertMessage(conversationId, ChatMessage.SENDER_ADMIN, admin.getId(), content);
        conversationDAO.touchLastMessageAt(conversationId);

        if (saved == null) {
            out.put("error", "Không thể lưu tin nhắn");
            resp.getWriter().write(out.toString());
            return;
        }

        JSONObject msgJson = new JSONObject();
        msgJson.put("id", saved.getId());
        msgJson.put("senderType", saved.getSenderType());
        msgJson.put("fromAdmin", true);
        msgJson.put("content", saved.getContent());
        msgJson.put("sentAt", formatTime(saved.getSentAt()));

        out.put("message", msgJson);
        resp.getWriter().write(out.toString());
    }

    private int parseIntSafe(String s, int defaultValue) {
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}
