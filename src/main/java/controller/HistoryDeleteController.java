package controller;

import java.io.IOException;


import dao.historyDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/history/delete")
public class HistoryDeleteController extends HttpServlet {

    private historyDAO dao;

    @Override	
    public void init() {
        dao = new historyDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("user");

        int userId = (u != null) ? u.getId() : 1;

        String action = req.getParameter("action");

        // ================= DELETE ONE =================
        if ("one".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteHistory(id);

        }

        // ================= DELETE ALL =================
        else if ("all".equals(action)) {

            dao.deleteAllHistory(userId);
        }

        resp.sendRedirect(req.getContextPath() + "/library");
    }
}