package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entity.FunFact;
import utils.DBContext;

public class FunFactDAO {

    public FunFact getRandomFact(int characterId) {

        String sql = """
            SELECT TOP 1 id, title, content
            FROM FunFacts
            WHERE related_character_id = ?
            ORDER BY NEWID()
        """;

        try (
            Connection con = DBContext.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, characterId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    FunFact fact = new FunFact();

                    fact.setId(rs.getInt("id"));
                    fact.setTitle(rs.getString("title"));
                    fact.setContent(rs.getString("content"));

                    return fact;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}