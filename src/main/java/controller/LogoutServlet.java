package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.SessionUtil;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        SessionUtil.logout(req);

        resp.sendRedirect(req.getContextPath() + "/");
    }
}