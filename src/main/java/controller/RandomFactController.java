package controller;

import java.io.IOException;

import dao.FunFactDAO;
import entity.FunFact;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/random-fact")
public class RandomFactController extends HttpServlet {

    private FunFactDAO factDao;

    @Override
    public void init() {
        factDao = new FunFactDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        int characterId =
                Integer.parseInt(req.getParameter("characterId"));

        FunFact fact =
                factDao.getRandomFact(characterId);

        resp.setContentType("application/json;charset=UTF-8");

        resp.getWriter().write(
            "{\"title\":\"" + fact.getTitle() +
            "\",\"content\":\"" + fact.getContent() + "\"}"
        );
    }
}
