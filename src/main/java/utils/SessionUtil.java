package utils;

import entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    private static final String USER_SESSION = "user";

    // Lưu user vào session
    public static void setUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute(USER_SESSION, user);
    }

    // Lấy user từ session
    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            return null;
        }

        return (User) session.getAttribute(USER_SESSION);
    }

    // Kiểm tra đã đăng nhập chưa
    public static boolean isAuthenticated(HttpServletRequest request) {
        return getUser(request) != null;
    }

    // Kiểm tra Admin
    public static boolean isAdmin(HttpServletRequest request) {

        User user = getUser(request);

        if (user == null) {
            return false;
        }

        return "admin".equalsIgnoreCase(user.getRole());
    }

    // Đăng xuất
    public static void logout(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }
    }

}