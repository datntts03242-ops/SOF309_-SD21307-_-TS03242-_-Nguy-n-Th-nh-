package controller;

import dao.UserDAO;
import entity.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


@WebServlet("/admin/users")
public class AdminUserController extends HttpServlet {


    UserDAO dao = new UserDAO();



    @Override
    protected void doGet(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException, IOException {


        String action = req.getParameter("action");


        // Xóa user nếu cần
        if("delete".equals(action)){

            int id = Integer.parseInt(
            req.getParameter("id"));


            dao.delete(id);

            resp.sendRedirect(
            req.getContextPath()+"/admin/users");

            return;
        }
        if("edit".equals(action)){

        	int id=Integer.parseInt(req.getParameter("id"));

        	User u=dao.getById(id);

        	req.setAttribute("editUser",u);

        	req.getRequestDispatcher(
        	"/views/admin/users/form.jsp")
        	.forward(req,resp);

        	return;

        	}



        	if("add".equals(action)){


        	req.getRequestDispatcher(
        	"/views/admin/users/form.jsp")
        	.forward(req,resp);

        	return;


        	}
        	
        	
        	
        	if ("banned".equals(action)) {
                List<User> bannedUsers = dao.findBannedUsers();
                req.setAttribute("bannedUsers", bannedUsers);
                req.getRequestDispatcher("/views/admin/users/list.jsp").forward(req, resp);
                return;
            }

            if ("violationDetail".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                User u = dao.getById(id);
                List<entity.ViolationHistory> violations = new dao.ViolationDAO().findByUserId(id);
                req.setAttribute("targetUser", u);
                req.setAttribute("violations", violations);
                req.getRequestDispatcher("/views/admin/users/violationDetail.jsp").forward(req, resp);
                return;
            }



            List<User> users = dao.findAll();
            List<User> bannedUsers = dao.findBannedUsers();

            req.setAttribute("users", users);
            req.setAttribute("bannedUsers", bannedUsers);

            req.getRequestDispatcher("/views/admin/users/list.jsp").forward(req, resp);

    }





    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        // Bật / khóa tài khoản
        if("active".equals(action)){

            int id = Integer.parseInt(req.getParameter("id"));
            boolean active = Boolean.parseBoolean(req.getParameter("active"));

            dao.updateActive(id, active);
        }

        // Khôi phục tài khoản vi phạm
        if("restore".equals(action)){

            int id = Integer.parseInt(req.getParameter("id"));
            dao.restoreUser(id);
        }

        resp.sendRedirect(req.getContextPath()+"/admin/users");
    }
}