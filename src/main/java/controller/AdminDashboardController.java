package controller;

import dao.ActivityLogDAO;
import dao.CharacterDAO;
import dao.CharacterSubmissionDAO;
import dao.DynastyDAO;
import dao.UserDAO;
import dao.CommentDAO;
import java.util.List;
import java.util.Map;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {


    CharacterDAO characterDAO          = new CharacterDAO();
    DynastyDAO dynastyDAO              = new DynastyDAO();
    UserDAO userDAO                    = new UserDAO();
    CommentDAO commentDAO              = new CommentDAO();
    CharacterSubmissionDAO submissionDAO = new CharacterSubmissionDAO();



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {


        HttpSession session = req.getSession();


        if(session.getAttribute("user") == null){
            resp.sendRedirect(req.getContextPath()+"/login");
            return;
        }



        ActivityLogDAO logDAO = new ActivityLogDAO();



        req.setAttribute("characterCount",  characterDAO.countCharacters());
        req.setAttribute("dynastyCount",    dynastyDAO.countDynasties());
        req.setAttribute("userCount",       userDAO.countUsers());
        req.setAttribute("commentCount",    commentDAO.countComments());
        req.setAttribute("dynastyChart",    characterDAO.countByDynasty());
        req.setAttribute("activities",      logDAO.getRecent());
        req.setAttribute("latestCharacters",characterDAO.getLatestCharacters());
        req.setAttribute("pendingSubmissions", submissionDAO.countPending());



        req.getRequestDispatcher(
        "/views/admin/dashboard.jsp")
        .forward(req, resp);

    }

}