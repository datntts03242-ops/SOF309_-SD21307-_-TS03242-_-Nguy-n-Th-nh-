package controller;

import java.io.IOException;

import dao.CommentDAO;
import dao.UserDAO;
import dao.ViolationDAO;
import entity.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.CommentModerationUtil;
import utils.SessionUtil;

@WebServlet("/comment")
public class CommentController extends HttpServlet {

    CommentDAO dao = new CommentDAO();
    ViolationDAO violationDAO = new ViolationDAO();
    UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        if (!SessionUtil.isAuthenticated(req)) {
            resp.sendRedirect("login");
            return;
        }
        try {
            req.setCharacterEncoding("UTF-8");

            int userId = Integer.parseInt(req.getParameter("uid"));
            int charId = Integer.parseInt(req.getParameter("cid"));
            String content = req.getParameter("content");
            int score = Integer.parseInt(req.getParameter("score"));

            String violationReason = CommentModerationUtil.checkViolation(content);

            if (violationReason != null) {
                // Không lưu comment, ghi nhận vi phạm
                violationDAO.insert(userId, content, violationReason);
                userDAO.incrementWarning(userId);

                User u = userDAO.getById(userId);
                int newCount = u.getWarningCount();

                if (newCount >= 5) {
                    userDAO.banUser(userId);
                    SessionUtil.logout(req);
                    req.getSession(true).setAttribute("flashMessage",
                        "Tài khoản của bạn đã bị khóa vĩnh viễn do vi phạm tiêu chuẩn cộng đồng.");
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }

                req.getSession(true).setAttribute("flashMessage",
                    "Bình luận của bạn chứa nội dung vi phạm tiêu chuẩn cộng đồng và không thể được đăng. "
                    + "Bạn đã vi phạm " + newCount + "/5 lần.");

                resp.sendRedirect(req.getContextPath() + "/characters?id=" + charId);
                return;
            }

            dao.addComment(userId, charId, content, score);
            resp.sendRedirect(req.getContextPath() + "/characters?id=" + charId);

        } catch (Exception e) {
            e.printStackTrace();

            String cid = req.getParameter("cid");
            if (cid != null) {
                resp.sendRedirect(req.getContextPath() + "/characters?id=" + cid);
            } else {
                resp.sendRedirect(req.getContextPath() + "/characters");
            }
        }
    }
}