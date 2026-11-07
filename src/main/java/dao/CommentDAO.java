package dao;

import java.sql.*;
import java.util.*;
import entity.Comment;
import utils.DBContext;

public class CommentDAO {

    // ── ADD ────────────────────────────────────────────────────
    public void addComment(int userId, int charId, String content, int score) {
        String sql = "INSERT INTO Comment(user_id, character_id, content, score) VALUES(?,?,?,?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, charId);
            ps.setString(3, content);
            ps.setInt(4, score);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ── GET LIST ───────────────────────────────────────────────
    public List<Comment> getComments(int charId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT c.*, u.username FROM Comment c " +
                     "LEFT JOIN Users u ON c.user_id = u.id " +
                     "WHERE c.character_id = ? ORDER BY c.created_at DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, charId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setContent(rs.getString("content"));
                c.setScore(rs.getInt("score"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                try { c.setUsername(rs.getString("username")); } catch (Exception ignored) {}
                list.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── DELETE ─────────────────────────────────────────────────
    public void deleteComment(int id, int userId, boolean isAdmin) {
        String sql = isAdmin ? "DELETE FROM Comment WHERE id=?"
                             : "DELETE FROM Comment WHERE id=? AND user_id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (!isAdmin) ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ── AVG RATING ─────────────────────────────────────────────
    public double getAvgRating(int charId) {
        String sql = "SELECT AVG(CAST(score AS FLOAT)) avgScore FROM Comment WHERE character_id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, charId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble("avgScore");
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── COUNT REVIEWS ──────────────────────────────────────────
    public int countReviews(int charId) {
        String sql = "SELECT COUNT(*) total FROM Comment WHERE character_id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, charId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("total");
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── COUNT ALL ──────────────────────────────────────────────
    public int countComments() {
        String sql = "SELECT COUNT(*) FROM Comment";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
