package controller;

import dao.ActivityLogDAO;
import dao.CharacterDAO;
import dao.CharacterSubmissionDAO;
import entity.Character;
import entity.CharacterSubmission;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/submissions")
public class AdminSubmissionController extends HttpServlet {

    private final CharacterSubmissionDAO dao  = new CharacterSubmissionDAO();
    private final CharacterDAO characterDAO   = new CharacterDAO();
    private final ActivityLogDAO logDAO       = new ActivityLogDAO();

    // ── GET: chỉ dùng để hiện danh sách ──────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String status = req.getParameter("status");
        if (status == null || status.isBlank()) status = "Pending";

        List<CharacterSubmission> list = dao.findAll(status);
        int pendingCount = dao.countPending();

        req.setAttribute("submissions",   list);
        req.setAttribute("currentStatus", status);
        req.setAttribute("pendingCount",  pendingCount);

        req.getRequestDispatcher("/views/admin/submissions/list.jsp")
           .forward(req, resp);
    }

    // ── POST: xử lý approve và reject ────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        User admin    = (User) req.getSession().getAttribute("user");

        // Kiểm tra admin null tránh NPE
        if (admin == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/submissions");
            return;
        }
        int id = Integer.parseInt(idParam);

        // ── APPROVE ───────────────────────────────────────────
        if ("approve".equals(action)) {
            CharacterSubmission s = dao.getById(id);

            if (s != null && "Pending".equals(s.getStatus())) {
                // Tạo nhân vật chính thức từ submission
                Character c = new Character();
                c.setName(s.getName());
                c.setDynasty(s.getDynasty() != null ? s.getDynasty() : "");
                c.setDescription(s.getDescription());
                c.setBiography(s.getBiography());
                c.setAchievement(s.getAchievement());
                c.setBirthPlace(s.getBirthPlace());
                c.setHistorical_site(s.getHistoricalSite());
                c.setImage(s.getImage() != null && !s.getImage().isBlank()
                    ? s.getImage() : "no-image.png");
                c.setYoutubeLink(s.getYoutubeLink() != null ? s.getYoutubeLink() : "");
                c.setTimelineOrder(s.getTimelineOrder() != null ? s.getTimelineOrder() : 0);

                characterDAO.insert(c);
                dao.approve(id, admin.getId());
                logDAO.insert(admin.getId(), "APPROVE_SUBMISSION", s.getName());

                resp.sendRedirect(req.getContextPath() + "/admin/submissions?status=Pending&msg=approved");
                return;
            }

            // Đã được duyệt/từ chối rồi
            resp.sendRedirect(req.getContextPath() + "/admin/submissions?status=Pending");
            return;
        }

        // ── REJECT ────────────────────────────────────────────
        if ("reject".equals(action)) {
            String reason = req.getParameter("reason");
            if (reason == null || reason.trim().isEmpty()) {
                reason = "Không đạt yêu cầu";
            }
            dao.reject(id, admin.getId(), reason.trim());
            logDAO.insert(admin.getId(), "REJECT_SUBMISSION", "ID: " + id + " — " + reason);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/submissions?status=Pending");
    }
}
