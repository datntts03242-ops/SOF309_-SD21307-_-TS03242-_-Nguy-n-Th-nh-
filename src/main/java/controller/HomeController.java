package controller;

import dao.CharacterDAO;
import entity.Character;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CharacterDAO dao = new CharacterDAO();
        List<Character> top6 = dao.findTop6Timeline();
        request.setAttribute("top6", top6);

        request.getRequestDispatcher("/views/home/index.jsp")
               .forward(request, response);
    }
}
