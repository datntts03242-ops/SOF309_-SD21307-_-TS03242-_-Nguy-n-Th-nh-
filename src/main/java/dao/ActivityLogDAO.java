package dao;


import entity.ActivityLog;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class ActivityLogDAO {

    // ================= INSERT LOG =================

    public void insert(int userId, String action, String target) {
        String sql = "INSERT INTO ActivityLog(user_id, action, target) VALUES(?,?,?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, action);
            ps.setString(3, target);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= GET RECENT =================

    public List<ActivityLog> getRecent() {
        List<ActivityLog> list = new ArrayList<>();
        String sql =
            """
            SELECT TOP 10
            a.id, a.user_id, a.action, a.target, a.created_at,
            u.fullname
            FROM ActivityLog a
            JOIN Users u ON a.user_id = u.id
            ORDER BY a.created_at DESC
            """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ActivityLog a = new ActivityLog();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setAction(rs.getString("action"));
                a.setTarget(rs.getString("target"));
                a.setCreatedAt(rs.getTimestamp("created_at"));
                a.setUsername(rs.getString("fullname"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================= DELETE OLD LOG (OPTIONAL) =================

    public void deleteOldLog() {
        String sql =
            """
            DELETE FROM ActivityLog
            WHERE created_at < DATEADD(day,-30,GETDATE())
            """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}