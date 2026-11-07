package controller;

import java.io.IOException;

import dao.historyDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/library")
public class HistoryController extends HttpServlet {

    private historyDAO dao;

    @Override
    public void init() {
        dao = new historyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("user");

        int userId = (u != null) ? u.getId() : 1;

        // ✅ FIX: đúng tên biến JSP đang dùng
        req.setAttribute("historyMap", dao.getHistoryGroupByDate(userId));
        req.setAttribute("activePage", "library");

        req.getRequestDispatcher("/views/library/library.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("user");

        int userId = (u != null) ? u.getId() : 1;

        String action = req.getParameter("action");

        try {
            if ("one".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteHistory(id);
            }

            if ("all".equals(action)) {
                dao.deleteAllHistory(userId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/library");
    }
}