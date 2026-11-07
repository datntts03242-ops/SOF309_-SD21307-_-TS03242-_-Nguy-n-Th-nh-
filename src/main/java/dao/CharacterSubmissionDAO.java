package dao;

import java.sql.*;
import java.util.*;
import entity.CharacterSubmission;
import utils.DBContext;

public class CharacterSubmissionDAO {

    // ── INSERT ──────────────────────────────────────────────────
    public boolean insert(CharacterSubmission c) {
        String sql = "INSERT INTO Character_Submissions "
                   + "(user_id,name,dynasty,dynasty_id,description,biography,"
                   + "achievement,birth_place,historical_site,image,youtube_link,"
                   + "timelineOrder,status) "
                   + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,'Pending')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getUserId());
            ps.setString(2, c.getName());
            ps.setString(3, c.getDynasty());
            if (c.getDynastyId() == null) ps.setNull(4, Types.INTEGER);
            else ps.setInt(4, c.getDynastyId());
            ps.setString(5, c.getDescription());
            ps.setString(6, c.getBiography());
            ps.setString(7, c.getAchievement());
            ps.setString(8, c.getBirthPlace());
            ps.setString(9, c.getHistoricalSite());
            ps.setString(10, c.getImage());
            ps.setString(11, c.getYoutubeLink());
            if (c.getTimelineOrder() == null) ps.setNull(12, Types.INTEGER);
            else ps.setInt(12, c.getTimelineOrder());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ── LIST ALL (admin) ────────────────────────────────────────
    public List<CharacterSubmission> findAll(String status) {
        List<CharacterSubmission> list = new ArrayList<>();
        String sql = "SELECT cs.*, u.username FROM Character_Submissions cs "
                   + "LEFT JOIN Users u ON cs.user_id = u.id ";
        if (status != null && !status.isBlank()) sql += "WHERE cs.status = ? ";
        sql += "ORDER BY cs.created_at DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (status != null && !status.isBlank()) ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── GET BY ID ────────────────────────────────────────────────
    public CharacterSubmission getById(int id) {
        String sql = "SELECT cs.*, u.username FROM Character_Submissions cs "
                   + "LEFT JOIN Users u ON cs.user_id = u.id WHERE cs.id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ── APPROVE ──────────────────────────────────────────────────
    public void approve(int id, int reviewerId) {
        String sql = "UPDATE Character_Submissions SET status='Approved', "
                   + "reviewed_by=?, reviewed_at=GETDATE() WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewerId);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ── REJECT ───────────────────────────────────────────────────
    public void reject(int id, int reviewerId, String reason) {
        String sql = "UPDATE Character_Submissions SET status='Rejected', "
                   + "reviewed_by=?, reviewed_at=GETDATE(), reject_reason=? WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewerId);
            ps.setString(2, reason);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ── COUNT PENDING ─────────────────────────────────────────────
    public int countPending() {
        String sql = "SELECT COUNT(*) FROM Character_Submissions WHERE status='Pending'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── MAP ROW ───────────────────────────────────────────────────
    private CharacterSubmission mapRow(ResultSet rs) throws Exception {
        CharacterSubmission s = new CharacterSubmission();
        s.setId(rs.getInt("id"));
        s.setUserId(rs.getInt("user_id"));
        s.setName(rs.getString("name"));
        s.setDynasty(rs.getString("dynasty"));
        s.setDescription(rs.getString("description"));
        s.setBiography(rs.getString("biography"));
        s.setAchievement(rs.getString("achievement"));
        s.setBirthPlace(rs.getString("birth_place"));
        s.setHistoricalSite(rs.getString("historical_site"));
        s.setImage(rs.getString("image"));
        s.setStatus(rs.getString("status"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        try { s.setRejectReason(rs.getString("reject_reason")); } catch (Exception ignored) {}
        try { s.setSubmitterUsername(rs.getString("username")); } catch (Exception ignored) {}
        return s;
    }
}
