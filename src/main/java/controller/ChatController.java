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
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import utils.SessionUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

/**
 * Servlet xử lý chat phía người dùng (đã đăng nhập) và khách (chưa đăng nhập).
 * Danh tính luôn được xác định từ session phía server, KHÔNG bao giờ tin
 * tham số gửi từ client (chống giả mạo sender_id).
 */
@WebServlet("/chat")
public class ChatController extends HttpServlet {

    private static final int MAX_CONTENT_LENGTH = 1000;
    private static final String SESSION_GUEST_ID_KEY = "chatGuestId";

    private final ChatConversationDAO conversationDAO = new ChatConversationDAO();
    private final ChatMessageDAO messageDAO = new ChatMessageDAO();

    // ================= HELPER: XÁC ĐỊNH DANH TÍNH TỪ SESSION =================

    private static class Identity {
        String type;       // "user" hoặc "guest"
        Integer userId;    // null nếu là guest
        String guestId;    // null nếu là user
    }

    private Identity resolveIdentity(HttpServletRequest req) {
        Identity identity = new Identity();

        User user = SessionUtil.getUser(req);
        if (user != null) {
            identity.type = ChatMessage.SENDER_USER;
            identity.userId = user.getId();
            return identity;
        }

        HttpSession session = req.getSession(true);
        String guestId = (String) session.getAttribute(SESSION_GUEST_ID_KEY);
        if (guestId == null) {
            guestId = UUID.randomUUID().toString();
            session.setAttribute(SESSION_GUEST_ID_KEY, guestId);
        }

        identity.type = ChatMessage.SENDER_GUEST;
        identity.guestId = guestId;
        return identity;
    }

    /** Tìm conversation hiện có (không tạo mới) - dùng cho init/poll/unread */
    private ChatConversation findExistingConversation(Identity identity) {
        if (identity.userId != null) {
            return conversationDAO.findByUserId(identity.userId);
        }
        return conversationDAO.findByGuestId(identity.guestId);
    }

    /** Lấy hoặc tạo mới conversation - chỉ dùng khi thực sự gửi tin nhắn */
    private ChatConversation getOrCreateConversation(Identity identity) {
        if (identity.userId != null) {
            return conversationDAO.getOrCreateForUser(identity.userId);
        }
        return conversationDAO.getOrCreateForGuest(identity.guestId);
    }

    private String formatTime(java.sql.Timestamp ts) {
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
            o.put("mine", !ChatMessage.SENDER_ADMIN.equals(m.getSenderType()));
            o.put("deleted", m.isDeleted());
            o.put("content", m.isDeleted() ? DELETED_PLACEHOLDER : m.getContent());
            o.put("sentAt", formatTime(m.getSentAt()));
            arr.put(o);
        }
        return arr;
    }

    // ================= GET: init / poll / unread =================

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        String action = req.getParameter("action");
        if (action == null) action = "init";

        Identity identity = resolveIdentity(req);
        JSONObject out = new JSONObject();

        try {
            switch (action) {

                case "unread": {
                    ChatConversation conv = findExistingConversation(identity);
                    int unread = (conv == null) ? 0 : messageDAO.countUnreadForUser(conv.getId());
                    out.put("unread", unread);
                    break;
                }

                case "poll": {
                    ChatConversation conv = findExistingConversation(identity);
                    int afterId = parseIntSafe(req.getParameter("afterId"), 0);

                    if (conv == null) {
                        out.put("conversationId", JSONObject.NULL);
                        out.put("messages", new JSONArray());
                        out.put("blocked", false);
                    } else {
                        List<ChatMessage> newMsgs = messageDAO.findNewMessages(conv.getId(), afterId);
                        messageDAO.markAllReadByUser(conv.getId());
                        out.put("conversationId", conv.getId());
                        out.put("messages", buildMessagesJson(newMsgs));
                        out.put("blocked", conv.isBlocked());
                    }
                    break;
                }

                case "init":
                default: {
                    ChatConversation conv = findExistingConversation(identity);

                    out.put("identityType", identity.type);

                    if (conv == null) {
                        out.put("conversationId", JSONObject.NULL);
                        out.put("messages", new JSONArray());
                        out.put("blocked", false);
                    } else {
                        List<ChatMessage> history = messageDAO.findByConversation(conv.getId());
                        messageDAO.markAllReadByUser(conv.getId());
                        out.put("conversationId", conv.getId());
                        out.put("messages", buildMessagesJson(history));
                        out.put("blocked", conv.isBlocked());
                    }
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out = new JSONObject();
            out.put("error", true);
        }

        resp.getWriter().write(out.toString());
    }

    // ================= POST: send =================

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String action = req.getParameter("action");
        JSONObject out = new JSONObject();

        if (!"send".equals(action)) {
            out.put("error", "Hành động không hợp lệ");
            resp.getWriter().write(out.toString());
            return;
        }

        String content = req.getParameter("content");
        String guestName = req.getParameter("guestName");

        if (content == null || content.trim().isEmpty()) {
            out.put("error", "Nội dung tin nhắn không được để trống");
            resp.getWriter().write(out.toString());
            return;
        }

        content = content.trim();
        if (content.length() > MAX_CONTENT_LENGTH) {
            content = content.substring(0, MAX_CONTENT_LENGTH);
        }

        try {
            Identity identity = resolveIdentity(req);
            ChatConversation conv = getOrCreateConversation(identity);

            if (conv == null) {
                out.put("error", "Không thể khởi tạo cuộc trò chuyện");
                resp.getWriter().write(out.toString());
                return;
            }

            if (conv.isBlocked()) {
                out.put("error", "Bạn đã bị quản trị viên chặn và không thể gửi tin nhắn nữa.");
                out.put("blocked", true);
                resp.getWriter().write(out.toString());
                return;
            }

            if (identity.type.equals(ChatMessage.SENDER_GUEST) && guestName != null && !guestName.trim().isEmpty()) {
                conversationDAO.updateGuestName(conv.getId(), guestName);
            }

            Integer senderUserId = identity.userId; // null nếu guest
            ChatMessage saved = messageDAO.insertMessage(conv.getId(), identity.type, senderUserId, content);
            conversationDAO.touchLastMessageAt(conv.getId());

            if (saved == null) {
                out.put("error", "Không thể lưu tin nhắn");
                resp.getWriter().write(out.toString());
                return;
            }

            JSONObject msgJson = new JSONObject();
            msgJson.put("id", saved.getId());
            msgJson.put("senderType", saved.getSenderType());
            msgJson.put("mine", true);
            msgJson.put("content", saved.getContent());
            msgJson.put("sentAt", formatTime(saved.getSentAt()));

            out.put("conversationId", conv.getId());
            out.put("message", msgJson);

        } catch (Exception e) {
            e.printStackTrace();
            out = new JSONObject();
            out.put("error", "Có lỗi xảy ra, vui lòng thử lại");
        }

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
