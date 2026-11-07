package controller;

import dao.ActivityLogDAO;
import dao.UserDAO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.SessionUtil;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/auth/login.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();

        // Tìm user theo username (chưa kiểm tra password ở đây)
        User user = dao.findByUsername(username);

        if (user == null) {
            // Không tìm thấy tài khoản
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra tài khoản có bị khóa không
        if (!user.getActive()) {
            req.setAttribute("error", "Tài khoản đã bị khóa. Vui lòng liên hệ quản trị viên.");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra mật khẩu (BCrypt)
        if (!org.mindrot.jbcrypt.BCrypt.checkpw(password, user.getPassword())) {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // Đăng nhập thành công
        SessionUtil.setUser(req, user);

        ActivityLogDAO logDAO = new ActivityLogDAO();
        logDAO.insert(user.getId(), "LOGIN", "Đăng nhập");

        resp.sendRedirect(req.getContextPath() + "/");
    }
}