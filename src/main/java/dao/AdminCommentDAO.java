package dao;

import java.sql.*;
import java.util.*;
import entity.Comment;
import utils.DBContext;

public class AdminCommentDAO {

    private static final String JOIN =
        "SELECT c.*, u.username, ch.name AS characterName " +
        "FROM Comment c " +
        "INNER JOIN Users u  ON c.user_id      = u.id " +
        "INNER JOIN Characters ch ON c.character_id = ch.id ";

    // ── LIST ─────────────────────────────────────────────────
    public List<Comment> findAll(String keyword, int page, int pageSize) {
        List<Comment> list = new ArrayList<>();
        String sql = JOIN +
            "WHERE u.username LIKE ? OR ch.name LIKE ? OR c.content LIKE ? " +
            "ORDER BY c.created_at DESC " +
            "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ps.setInt(4, (page - 1) * pageSize);
            ps.setInt(5, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── COUNT ─────────────────────────────────────────────────
    public int count(String keyword) {
        String sql =
            "SELECT COUNT(*) FROM Comment c " +
            "INNER JOIN Users u  ON c.user_id      = u.id " +
            "INNER JOIN Characters ch ON c.character_id = ch.id " +
            "WHERE u.username LIKE ? OR ch.name LIKE ? OR c.content LIKE ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── GET BY ID ──────────────────────────────────────────────
    public Comment getById(int id) {
        String sql = JOIN + "WHERE c.id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ── DELETE ─────────────────────────────────────────────────
    public void delete(int id) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM Comment WHERE id=?")) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }

    // ── MAP ROW ────────────────────────────────────────────────
    private Comment mapRow(ResultSet rs) throws Exception {
        Comment c = new Comment();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setCharacterId(rs.getInt("character_id"));
        c.setUsername(rs.getString("username"));
        c.setCharacterName(rs.getString("characterName"));
        c.setContent(rs.getString("content"));
        c.setScore(rs.getInt("score"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}
