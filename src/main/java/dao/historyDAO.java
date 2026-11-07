package dao;

import java.sql.*;
import java.util.*;
import entity.History;
import utils.DBContext;

public class historyDAO {

    public List<History> getHistory(int userId) {

        List<History> list = new ArrayList<>();

        String sql = """
            SELECT h.id,
		       h.character_id,
		       c.name,
		       c.image,
		       h.view_time
            FROM history h
            JOIN characters c ON c.id = h.character_id
            WHERE h.user_id = ?
            ORDER BY h.view_time DESC
        """;

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                History h = new History();
                
                h.setId(rs.getInt("id"));
                h.setCharacterId(rs.getInt("character_id"));
                h.setCharacterName(rs.getString("name"));
                h.setImage(rs.getString("image"));
                h.setViewTime(rs.getString("view_time"));

                list.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 👉 thêm history khi xem detail
    public void addOrUpdateHistory(int userId, int characterId) {

        String checkSql = "SELECT id FROM history WHERE user_id=? AND character_id=?";

        try (Connection conn = DBContext.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(checkSql);
            ps.setInt(1, userId);
            ps.setInt(2, characterId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                PreparedStatement update = conn.prepareStatement(
                    "UPDATE history SET view_time = GETDATE() WHERE user_id=? AND character_id=?"
                );
                update.setInt(1, userId);
                update.setInt(2, characterId);
                update.executeUpdate();
            } else {
                PreparedStatement insert = conn.prepareStatement(
                    "INSERT INTO history(user_id, character_id, view_time) VALUES (?, ?, GETDATE())"
                );
                insert.setInt(1, userId);
                insert.setInt(2, characterId);
                insert.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Map<String, List<History>> getHistoryGroupByDate(int userId) {

        Map<String, List<History>> map = new LinkedHashMap<>();

        String sql = """
            SELECT h.id, h.character_id, c.name, c.image, h.view_time
            FROM history h
            JOIN characters c ON c.id = h.character_id
            WHERE h.user_id = ?
            ORDER BY h.view_time DESC
        """;

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                History h = new History();
                h.setId(rs.getInt("id"));
                h.setCharacterId(rs.getInt("character_id"));
                h.setCharacterName(rs.getString("name"));
                h.setImage(rs.getString("image"));

                Timestamp ts = rs.getTimestamp("view_time");
                String date = ts.toString().substring(0, 10);
                h.setViewTime(rs.getString("view_time"));

                map.computeIfAbsent(date, k -> new ArrayList<>()).add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
    public void deleteHistory(int id) {

        String sql = "DELETE FROM history WHERE id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void deleteAllHistory(int userId) {

        String sql = "DELETE FROM history WHERE user_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}