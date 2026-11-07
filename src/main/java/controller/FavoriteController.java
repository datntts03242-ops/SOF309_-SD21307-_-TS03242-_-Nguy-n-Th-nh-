package controller;

import java.io.IOException;

import dao.FavoriteDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/favorite")
public class FavoriteController extends HttpServlet {

    private FavoriteDAO dao;

    @Override
    public void init() {
        dao = new FavoriteDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        try {

            String uidStr = req.getParameter("uid");
            String cidStr = req.getParameter("cid");

            if (uidStr == null || cidStr == null) {
                resp.getWriter().write("{\"error\":true}");
                return;
            }

            int userId = Integer.parseInt(uidStr);
            int charId = Integer.parseInt(cidStr);

            boolean isFav = dao.isFavorite(userId, charId);

            boolean newState;

            if (isFav) {
                dao.remove(userId, charId);
                newState = false;
            } else {
                dao.add(userId, charId);
                newState = true;
            }

            resp.getWriter().write(
                "{\"favorite\":" + newState + "}"
            );

        } catch (Exception e) {
            e.printStackTrace();

            resp.getWriter().write("{\"error\":true}");
        }
    }}