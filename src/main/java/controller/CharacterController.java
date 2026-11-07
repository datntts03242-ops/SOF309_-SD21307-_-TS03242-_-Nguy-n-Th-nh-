package controller;

import java.io.IOException;
import java.util.List;

import dao.CharacterDAO;
import dao.CommentDAO;
import dao.FavoriteDAO;
import dao.FunFactDAO;
import dao.historyDAO;

import entity.Character;
import entity.FunFact;
import entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/characters")
public class CharacterController extends HttpServlet {

private CharacterDAO charDao;
private FavoriteDAO favDao;
private CommentDAO commentDao;
private historyDAO historyDao;
private FunFactDAO factDao;

@Override
public void init() {
    charDao = new CharacterDAO();
    favDao = new FavoriteDAO();
    commentDao = new CommentDAO();
    historyDao = new historyDAO();
    factDao = new FunFactDAO();
}

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

    req.setCharacterEncoding("UTF-8");
    resp.setContentType("text/html;charset=UTF-8");

    HttpSession session = req.getSession(false);
    User user = (session != null)
            ? (User) session.getAttribute("user")
            : null;

    int userId = (user != null) ? user.getId() : 0;

    String idParam = req.getParameter("id");

    // ================= DETAIL =================
    if (idParam != null && !idParam.trim().isEmpty()) {

        try {

            int id = Integer.parseInt(idParam);

            Character c = charDao.getById(id);

            if (c == null) {
                resp.sendRedirect(req.getContextPath() + "/characters");
                return;
            }

            if (user != null) {
                historyDao.addOrUpdateHistory(user.getId(), id);
            }

            boolean isFavorite = (user != null)
                    ? favDao.isFavorite(user.getId(), id)
                    : false;

            FunFact funFact = factDao.getRandomFact(id);

            req.setAttribute("character", c);
            req.setAttribute("funFact", funFact);
            req.setAttribute("isFavorite", isFavorite);
            req.setAttribute("comments", commentDao.getComments(id));
            req.setAttribute("avgRating", commentDao.getAvgRating(id));
            req.setAttribute("totalReviews", commentDao.countReviews(id));

            req.getRequestDispatcher("/views/character/detail.jsp")
                    .forward(req, resp);
            return;

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/characters");
            return;
        }
    }

    // ================= LIST =================

    String keyword = req.getParameter("keyword");
    String dynasty = req.getParameter("dynasty");
    String pageParam = req.getParameter("page");

    keyword = (keyword == null) ? "" : keyword.trim();
    dynasty = (dynasty == null) ? "" : dynasty.trim();

    int page = 1;
    int pageSize = 6;

    try {
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
            if (page < 1) page = 1;
        }
    } catch (Exception e) {
        page = 1;
    }

    List<Character> list =
            charDao.findAll(keyword, dynasty, page, pageSize);

    int total =
            charDao.countAll(keyword, dynasty);

    int totalPages =
            (int) Math.ceil((double) total / pageSize);

    if (totalPages == 0) totalPages = 1;

    List<Integer> favIds =
            (user != null)
                    ? favDao.getFavoriteIds(userId)
                    : List.of();

    req.setAttribute("characters", list);
    req.setAttribute("currentPage", page);
    req.setAttribute("totalPages", totalPages);
    req.setAttribute("keyword", keyword);
    req.setAttribute("dynasty", dynasty);
    req.setAttribute("favIds", favIds);

    req.getRequestDispatcher("/views/character/list.jsp")
            .forward(req, resp);
}

}
