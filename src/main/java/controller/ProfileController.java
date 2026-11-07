package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/profile")
@MultipartConfig
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/user/profile.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Part filePart = req.getPart("avatar");

        if (filePart != null && filePart.getSize() > 0) {

            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = req.getServletContext().getRealPath("/uploads");

            File dir = new File(uploadPath);
            if (!dir.exists()) dir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);

            // update DB
            UserDAO dao = new UserDAO();
            dao.updateAvatar(user.getUsername(), fileName);

            // update session (QUAN TRỌNG)
            user.setAvatar(fileName);
            session.setAttribute("user", user);
        }
        req.setAttribute("activePage", "profile");
       
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}