package controller;

import dao.RankingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ranking")
public class RankingController extends HttpServlet {

    private RankingDAO rankingDAO=new RankingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException,IOException{

        request.setAttribute(
                "ranking",
                rankingDAO.getTop10()
        );

        request.getRequestDispatcher(
                "/views/quiz/ranking.jsp"
        ).forward(request,response);

    }

}