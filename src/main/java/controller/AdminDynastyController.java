package controller;

import dao.DynastyDAO;
import entity.Dynasty;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dynasties")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class AdminDynastyController extends HttpServlet {

    DynastyDAO dao = new DynastyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/dynasties");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Dynasty d = dao.findById(id);
            req.setAttribute("editDynasty", d);
        }

        List<Dynasty> list = dao.findAll();

        req.setAttribute("dynasties", list);

        req.getRequestDispatcher("/views/admin/dynasties/list.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        Dynasty d = new Dynasty();

        d.setName(req.getParameter("name"));
        d.setFounder(req.getParameter("founder"));
        d.setStartYear(Integer.parseInt(req.getParameter("startYear")));
        d.setEndYear(Integer.parseInt(req.getParameter("endYear")));
        d.setCapital(req.getParameter("capital"));
        d.setDescription(req.getParameter("description"));

        // upload ảnh

        Part part = req.getPart("image");

        if (part != null && part.getSize() > 0) {

            String fileName = part.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("/uploads");

            File dir = new File(uploadPath);

            if (!dir.exists()) dir.mkdirs();

            part.write(uploadPath + File.separator + fileName);

            d.setImage(fileName);
        }

        if ("insert".equals(action)) {

            dao.insert(d);

        } else if ("update".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));

            Dynasty old = dao.findById(id);

            if (d.getName().isEmpty()) d.setName(old.getName());
            if (d.getFounder().isEmpty()) d.setFounder(old.getFounder());
            if (d.getCapital().isEmpty()) d.setCapital(old.getCapital());
            if (d.getDescription().isEmpty()) d.setDescription(old.getDescription());

            if (d.getImage() == null)
                d.setImage(old.getImage());

            d.setId(id);

            dao.update(d);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/dynasties");
    }

}