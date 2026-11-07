package controller;

import java.io.IOException;

import dao.FavoriteDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/favorites")
public class FavoritePageController extends HttpServlet {

    private FavoriteDAO dao;

    @Override
    public void init() {
        dao = new FavoriteDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        int userId = (user != null) ? user.getId() : 0;

        req.setAttribute("activePage", "favorites");
        req.setAttribute("favorites", dao.getFavorites(userId));

        req.getRequestDispatcher("/views/user/favorite.jsp")
           .forward(req, resp);
    }
}
