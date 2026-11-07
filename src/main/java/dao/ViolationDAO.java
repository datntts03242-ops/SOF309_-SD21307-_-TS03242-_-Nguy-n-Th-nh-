package dao;

import entity.ViolationHistory;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ViolationDAO {

    public void insert(int userId, String commentContent, String reason) {
        String sql = "INSERT INTO ViolationHistory(user_id, comment_content, violation_reason) VALUES(?,?,?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, commentContent);
            ps.setString(3, reason);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<ViolationHistory> findByUserId(int userId) {
        List<ViolationHistory> list = new ArrayList<>();
        String sql = "SELECT * FROM ViolationHistory WHERE user_id=? ORDER BY created_at DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ViolationHistory v = new ViolationHistory();
                v.setId(rs.getInt("id"));
                v.setUserId(rs.getInt("user_id"));
                v.setCommentContent(rs.getString("comment_content"));
                v.setViolationReason(rs.getString("violation_reason"));
                v.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(v);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}