package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/auth/register.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");

        UserDAO dao = new UserDAO();

        if (dao.findByUsername(username) != null) {
            req.setAttribute("error", "Tài khoản đã tồn tại");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        User u = new User();
        u.setUsername(username);
        // Hash mật khẩu bằng BCrypt trước khi lưu
        u.setPassword(org.mindrot.jbcrypt.BCrypt.hashpw(password, org.mindrot.jbcrypt.BCrypt.gensalt()));
        u.setFullname(fullname);

        try {
			if (dao.insert(u)) {
			    resp.sendRedirect(req.getContextPath() + "/login");
			} else {
			    req.setAttribute("error", "Đăng ký thất bại");
			    req.getRequestDispatcher("/views/auth/register.jsp")
			       .forward(req, resp);
			}
		} catch (SQLException | IOException | ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}