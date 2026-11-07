package controller;

import java.io.*;
import dao.CharacterSubmissionDAO;
import entity.CharacterSubmission;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/submit-character")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 5,
    maxRequestSize    = 1024 * 1024 * 10
)
public class CharacterSubmissionController extends HttpServlet {

    private CharacterSubmissionDAO dao;

    @Override
    public void init() {
        dao = new CharacterSubmissionDAO();
    }

    // ── GET: hiển thị form ────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/views/character/submit.jsp").forward(req, resp);
    }

    // ── POST: xử lý form ──────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String name        = req.getParameter("name");
        String dynasty     = req.getParameter("dynasty");
        String description = req.getParameter("description");

        // Validate bắt buộc
        if (name == null || name.trim().isEmpty()
                || dynasty == null || dynasty.trim().isEmpty()
                || description == null || description.trim().isEmpty()) {

            req.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            req.getRequestDispatcher("/views/character/submit.jsp").forward(req, resp);
            return;
        }

        CharacterSubmission c = new CharacterSubmission();
        c.setUserId(user.getId());
        c.setName(name.trim());
        c.setDynasty(dynasty.trim());
        c.setDescription(description.trim());
        c.setBiography(req.getParameter("biography"));
        c.setAchievement(req.getParameter("achievement"));
        c.setBirthPlace(req.getParameter("birthPlace"));
        c.setHistoricalSite(req.getParameter("historicalSite"));

        // Upload ảnh (không bắt buộc)
        try {
            Part imagePart = req.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName   = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/uploads");
                new File(uploadPath).mkdirs();
                imagePart.write(uploadPath + File.separator + fileName);
                c.setImage(fileName);
            }
        } catch (Exception ignored) { }

        dao.insert(c);

        req.getSession().setAttribute("toast", "✅ Đã gửi đóng góp! Admin sẽ xem xét sớm.");
        resp.sendRedirect(req.getContextPath() + "/characters");
    }
}
