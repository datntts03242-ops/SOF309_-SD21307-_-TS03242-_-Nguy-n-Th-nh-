package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.Character;
import utils.DBContext;

public class FavoriteDAO {

    // ⭐ CHECK FAVORITE
    public boolean isFavorite(int userId, int charId) {

        try (Connection conn = DBContext.getConnection()) {

            String sql = "SELECT 1 FROM Favorite WHERE user_id=? AND character_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, charId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ❤️ ADD FAVORITE
    public void add(int userId, int charId) {

        try (Connection conn = DBContext.getConnection()) {

            String sql = "INSERT INTO Favorite(user_id, character_id) VALUES(?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, charId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 💔 REMOVE FAVORITE
    public void remove(int userId, int charId) {

        try (Connection conn = DBContext.getConnection()) {

            String sql = "DELETE FROM Favorite WHERE user_id=? AND character_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, charId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 📌 GET FAVORITE IDS (for list UI)
    public List<Integer> getFavoriteIds(int userId) {

        List<Integer> list = new ArrayList<>();

        try (Connection conn = DBContext.getConnection()) {

            String sql = "SELECT character_id FROM Favorite WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("character_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 📌 GET FULL FAVORITES
    public List<Character> getFavorites(int userId) {

        List<Character> list = new ArrayList<>();

        try (Connection conn = DBContext.getConnection()) {

            String sql =
                "SELECT c.* FROM Characters c " +
                "JOIN Favorite f ON c.id = f.character_id " +
                "WHERE f.user_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Character c = new Character();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setImage(rs.getString("image"));
                c.setDynasty(rs.getString("dynasty"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}