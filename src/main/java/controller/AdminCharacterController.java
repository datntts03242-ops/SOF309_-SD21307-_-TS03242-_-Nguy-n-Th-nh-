package controller;

import dao.ActivityLogDAO;
import dao.CharacterDAO;
import dao.DynastyDAO;
import entity.Character;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/characters")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 20)
public class AdminCharacterController extends HttpServlet {

    private CharacterDAO dao = new CharacterDAO();
    private DynastyDAO dynastyDAO = new DynastyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");

        // 1. Chuyển nhân vật vào Thùng rác (Soft Delete)
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Character old = dao.getById(id);
            dao.softDelete(id);

            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                new ActivityLogDAO().insert(user.getId(), "DELETE_CHARACTER", old != null ? old.getName() : "ID: " + id);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/characters");
            return;
        }

        // 2. Khôi phục nhân vật từ Thùng rác
        if ("restore".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.restore(id);

            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                new ActivityLogDAO().insert(user.getId(), "RESTORE_CHARACTER", "ID: " + id);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/characters?action=trash");
            return;
        }

        // 3. Xóa vĩnh viễn khỏi Database
        if ("hard-delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deletePermanent(id);

            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                new ActivityLogDAO().insert(user.getId(), "PERMANENT_DELETE_CHARACTER", "ID: " + id);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/characters?action=trash");
            return;
        }

        // 4. Mở trang Thùng rác
        if ("trash".equals(action)) {
            List<Character> trashList = dao.findDeleted();
            req.setAttribute("trashList", trashList);
            req.getRequestDispatcher("/views/admin/characters/trash.jsp").forward(req, resp);
            return;
        }

        // 5. Chuẩn bị dữ liệu Sửa nhân vật
        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("editCharacter", dao.getById(id));
        }

        // 6. Hiển thị danh sách chính & Tìm kiếm/Phân trang
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";

        String dynasty = req.getParameter("dynasty");
        if (dynasty == null) dynasty = "";

        int page = 1;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception e) {}

        int pageSize = 10;

        List<Character> list = dao.findAll(keyword, dynasty, page, pageSize);
        int totalRecord = dao.countAll(keyword, dynasty);
        int totalPage = (int) Math.ceil((double) totalRecord / pageSize);

        req.setAttribute("characters", list);
        req.setAttribute("dynasties", dynastyDAO.getAll());

        req.setAttribute("keyword", keyword);
        req.setAttribute("dynasty", dynasty);

        req.setAttribute("page", page);
        req.setAttribute("totalPage", totalPage);

        req.getRequestDispatcher("/views/admin/characters/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        Character c = new Character();
        c.setName(req.getParameter("name"));

        // Lấy thông tin triều đại từ form (đồng bộ giữa dynasty_id và dynasty)
        String dynastyParam = req.getParameter("dynasty_id");
        if (dynastyParam == null || dynastyParam.isBlank()) {
            dynastyParam = req.getParameter("dynasty");
        }
        c.setDynasty(dynastyParam);

        c.setDescription(req.getParameter("description"));
        c.setBiography(req.getParameter("biography"));
        c.setAchievement(req.getParameter("achievement"));
        c.setBirthPlace(req.getParameter("birth_place"));
        c.setHistorical_site(req.getParameter("historical_site"));
        c.setYoutubeLink(req.getParameter("youtube_link"));

        String order = req.getParameter("timelineOrder");
        c.setTimelineOrder(order == null || order.isBlank() ? 0 : Integer.parseInt(order));

        Part imagePart = req.getPart("image");

        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = imagePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/uploads");

            java.io.File dir = new java.io.File(uploadPath);
            if (!dir.exists()) dir.mkdirs();

            imagePart.write(uploadPath + java.io.File.separator + fileName);
            c.setImage(fileName);
        }

        User user = (User) req.getSession().getAttribute("user");
        ActivityLogDAO logDAO = new ActivityLogDAO();

        if ("insert".equals(action)) {

            dao.insert(c);
            if (user != null) {
                logDAO.insert(user.getId(), "ADD_CHARACTER", c.getName());
            }

        } else if ("update".equals(action)) {

            int id = Integer.parseInt(req.getParameter("id"));
            Character old = dao.getById(id);

            if (c.getName() == null || c.getName().isBlank()) c.setName(old.getName());
            if (c.getDynasty() == null || c.getDynasty().isBlank()) c.setDynasty(old.getDynasty());
            if (c.getDescription() == null || c.getDescription().isBlank()) c.setDescription(old.getDescription());
            if (c.getBiography() == null || c.getBiography().isBlank()) c.setBiography(old.getBiography());
            if (c.getAchievement() == null || c.getAchievement().isBlank()) c.setAchievement(old.getAchievement());
            if (c.getBirthPlace() == null || c.getBirthPlace().isBlank()) c.setBirthPlace(old.getBirthPlace());
            if (c.getHistorical_site() == null || c.getHistorical_site().isBlank()) c.setHistorical_site(old.getHistorical_site());
            if (c.getImage() == null || c.getImage().isBlank()) c.setImage(old.getImage());
            if (c.getYoutubeLink() == null || c.getYoutubeLink().isBlank()) c.setYoutubeLink(old.getYoutubeLink());

            c.setId(id);

            dao.update(c);

            if (user != null) {
                logDAO.insert(user.getId(), "UPDATE_CHARACTER", c.getName());
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/characters");
    }
}