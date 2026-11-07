package dao;

import java.sql.*;
import java.util.*;

import entity.Character;
import utils.DBContext;

public class CharacterDAO {

    // ================= LIST (CHỈ LẤY NHÂN VẬT CHƯA XÓA) =================
    public List<Character> findAll(String keyword, String dynasty, int page, int pageSize) {
        List<Character> list = new ArrayList<>();

        // Chỉ lấy các nhân vật có is_deleted = 0 hoặc NULL
        String sql = "SELECT * FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL)";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }

        if (dynasty != null && !dynasty.trim().isEmpty()) {
            sql += " AND dynasty=?";
        }

        sql += " ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int i = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(i++, "%" + keyword.trim() + "%");
            }

            if (dynasty != null && !dynasty.trim().isEmpty()) {
                ps.setString(i++, dynasty.trim());
            }

            ps.setInt(i++, (page - 1) * pageSize);
            ps.setInt(i, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Character c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDynasty(rs.getString("dynasty"));
                c.setDescription(rs.getString("description"));
                c.setBiography(rs.getString("biography"));
                c.setAchievement(rs.getString("achievement"));
                c.setBirthPlace(rs.getString("birth_place"));
                c.setHistorical_site(rs.getString("historical_site"));
                c.setImage(rs.getString("image"));
                c.setYoutubeLink(rs.getString("youtube_link"));
                c.setTimelineOrder(rs.getInt("timelineOrder"));
                
                // Đọc cột is_deleted nếu có
                try {
                    c.setDeleted(rs.getBoolean("is_deleted"));
                } catch (Exception ignored) {}

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= COUNT (ĐẾM CÁC NHÂN VẬT CHƯA XÓA) =================
    public int count(String keyword, String dynasty) {
        return countAll(keyword, dynasty);
    }
    public int countAll(String keyword, String dynasty) {
        String sql = "SELECT COUNT(*) FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL)";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }

        if (dynasty != null && !dynasty.trim().isEmpty()) {
            sql += " AND dynasty = ?";
        }

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int i = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(i++, "%" + keyword.trim() + "%");
            }

            if (dynasty != null && !dynasty.trim().isEmpty()) {
                ps.setString(i++, dynasty.trim());
            }

            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int totalPages(String keyword, String dynasty, int pageSize) {
        int total = countAll(keyword, dynasty);
        return (int) Math.ceil(total * 1.0 / pageSize);
    }

    // ================= DETAIL =================
    public Character getById(int id) {
        Character c = null;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM Characters WHERE id=?")) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDynasty(rs.getString("dynasty"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));
                c.setBiography(rs.getString("biography"));
                c.setAchievement(rs.getString("achievement"));
                c.setBirthPlace(rs.getString("birth_place"));
                c.setYoutubeLink(rs.getString("youtube_link"));
                c.setHistorical_site(rs.getString("historical_site"));
                c.setTimelineOrder(rs.getInt("timelineOrder"));
                try {
                    c.setDeleted(rs.getBoolean("is_deleted"));
                } catch (Exception ignored) {}
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

    // ================= THÙNG RÁC / XÓA MỀM (CÁC HÀM MỚI BỔ SUNG) =================

    // 1. Chuyển nhân vật vào Thùng Rác (Xóa mềm)
    public void softDelete(int id) {
        String sql = "UPDATE Characters SET is_deleted = 1 WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void delete(int id) {
        softDelete(id);
    }

    // 2. Lấy danh sách nhân vật ĐÃ BỊ XÓA (Nằm trong thùng rác)
    public List<Character> findDeleted() {
        List<Character> list = new ArrayList<>();
        String sql = "SELECT * FROM Characters WHERE is_deleted = 1 ORDER BY id DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Character c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDynasty(rs.getString("dynasty"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));
                c.setDeleted(true);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. Khôi phục nhân vật từ thùng rác về lại danh sách
    public void restore(int id) {
        String sql = "UPDATE Characters SET is_deleted = 0 WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 4. Xóa vĩnh viễn khỏi Database (Hard Delete)
    public void deletePermanent(int id) {
        String sql = "DELETE FROM Characters WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= INSERT CHARACTER =================
    public void insert(Character c) {
        String sql = "INSERT INTO Characters(name, dynasty, description, biography, achievement, birth_place, historical_site, image, youtube_link, timelineOrder, avgRating, is_deleted) VALUES(?,?,?,?,?,?,?,?,?,?,?,0)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getName() != null ? c.getName() : "");
            ps.setString(2, c.getDynasty() != null ? c.getDynasty() : "");
            ps.setString(3, c.getDescription() != null ? c.getDescription() : "");
            ps.setString(4, c.getBiography() != null ? c.getBiography() : "");
            ps.setString(5, c.getAchievement() != null ? c.getAchievement() : "");
            ps.setString(6, c.getBirthPlace() != null ? c.getBirthPlace() : "");
            ps.setString(7, c.getHistorical_site() != null ? c.getHistorical_site() : "");
            // Dùng no-image.png nếu không có ảnh — tránh vỡ layout card
            String img = c.getImage();
            ps.setString(8, (img != null && !img.isBlank()) ? img : "no-image.png");
            ps.setString(9, c.getYoutubeLink() != null ? c.getYoutubeLink() : "");
            ps.setInt(10, c.getTimelineOrder());
            ps.setDouble(11, 0);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= UPDATE =================
    public void update(Character c) {
        String sql = "UPDATE Characters SET " +
                "name=?, dynasty=?, description=?, biography=?, " +
                "achievement=?, birth_place=?, historical_site=?, " +
                "image=?, youtube_link=?, timelineOrder=? " +
                "WHERE id=?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getName());
            ps.setString(2, c.getDynasty());
            ps.setString(3, c.getDescription());
            ps.setString(4, c.getBiography());
            ps.setString(5, c.getAchievement());
            ps.setString(6, c.getBirthPlace());
            ps.setString(7, c.getHistorical_site());
            ps.setString(8, c.getImage());
            ps.setString(9, c.getYoutubeLink());
            ps.setInt(10, c.getTimelineOrder());
            ps.setInt(11, c.getId()); // Đã sửa chỉ số gán đúng cho ID

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= TIMELINE & KHÁC =================
    public List<Character> findTop6Timeline() {
        List<Character> list = new ArrayList<>();
        String sql = "SELECT * FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL) AND name IN (" +
                "N'Ngô Quyền', N'Lý Thường Kiệt', N'Đinh Bộ Lĩnh', N'Trần Hưng Đạo', N'Lê Lợi', N'Quang Trung'" +
                ") ORDER BY id";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Character c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDynasty(rs.getString("dynasty"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Character> getRandomCharacters(int limit) {
        List<Character> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL) ORDER BY NEWID()";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Character c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDynasty(rs.getString("dynasty"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // DASHBOARD & STATS
    public int countCharacters() {
        String sql = "SELECT COUNT(*) FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> countByDynasty() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT dynasty, COUNT(*) AS total FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL) GROUP BY dynasty ORDER BY total DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("dynasty", rs.getString("dynasty"));
                map.put("total", rs.getInt("total"));
                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Character> getLatestCharacters() {
        List<Character> list = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM Characters WHERE (is_deleted = 0 OR is_deleted IS NULL) ORDER BY id DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Character c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDynasty(rs.getString("dynasty"));
                c.setImage(rs.getString("image"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}