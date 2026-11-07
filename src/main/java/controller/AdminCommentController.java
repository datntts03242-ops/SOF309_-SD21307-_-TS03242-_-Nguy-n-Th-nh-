package controller;

import java.io.IOException;
import java.util.List;

import dao.ActivityLogDAO;
import dao.AdminCommentDAO;
import entity.Comment;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/comments")
public class AdminCommentController extends HttpServlet {

    private AdminCommentDAO dao = new AdminCommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ================= DELETE =================
        if ("delete".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));

            Comment old = dao.getById(id);

            dao.delete(id);

            User user = (User) req.getSession().getAttribute("user");

            if (user != null && old != null) {
                new ActivityLogDAO().insert(
                        user.getId(),
                        "DELETE_COMMENT",
                        old.getContent()
                );
            }

            resp.sendRedirect(req.getContextPath() + "/admin/comments");
            return;
        }

        // ================= SEARCH =================

        String keyword = req.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }

        // ================= PAGINATION =================

        int page = 1;

        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception e) {
        }

        int pageSize = 10;

        List<Comment> list = dao.findAll(keyword, page, pageSize);

        int totalRecord = dao.count(keyword);

        int totalPage = (int) Math.ceil((double) totalRecord / pageSize);

        req.setAttribute("comments", list);

        req.setAttribute("keyword", keyword);

        req.setAttribute("page", page);

        req.setAttribute("totalPage", totalPage);

        req.getRequestDispatcher("/views/admin/comments/list.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        doGet(req, resp);

    }

}