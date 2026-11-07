package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import dao.DynastyDAO;

@WebServlet("/dynasties")
public class DynastyController extends HttpServlet {

    private DynastyDAO dao;

    @Override
    public void init() {
        dao = new DynastyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");

        // ================= DETAIL =================
        if (idParam != null) {

            int id = Integer.parseInt(idParam);

            req.setAttribute("dynasty", dao.findById(id));
            req.setAttribute("characters", dao.getCharacters(id));

            req.getRequestDispatcher("/views/dynasty/detail.jsp")
                    .forward(req, resp);
            return;
        }

        // ================= LIST =================
        req.setAttribute("list", dao.findAll());

        req.getRequestDispatcher("/views/dynasty/list.jsp")
                .forward(req, resp);
    }
}