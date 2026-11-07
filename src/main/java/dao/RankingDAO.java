package dao;

import entity.QuizResult;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RankingDAO {

	public List<QuizResult> getTop10() {

	    List<QuizResult> list = new ArrayList<>();

	    String sql = """
	        SELECT TOP 10
	            u.username,
	            q.score,
	            q.percentage,
	            q.difficulty,
	            q.created_at
	        FROM QuizResult q
	        JOIN Users u
	            ON q.user_id = u.id
	        WHERE q.id IN
	        (
	            SELECT id
	            FROM
	            (
	                SELECT *,
	                       ROW_NUMBER() OVER(
	                            PARTITION BY user_id
	                            ORDER BY score DESC, created_at DESC
	                       ) rn
	                FROM QuizResult
	            ) t
	            WHERE rn = 1
	        )
	        ORDER BY q.score DESC,
	                 q.created_at ASC
	        """;

	    try(Connection conn = DBContext.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery()){

	        while(rs.next()){

	            QuizResult r = new QuizResult();

	            r.setUserName(rs.getString("username"));
	            r.setScore(rs.getInt("score"));
	            r.setPercentage(rs.getDouble("percentage"));
	            r.setDifficulty(rs.getInt("difficulty"));
	            r.setCreatedAt(rs.getTimestamp("created_at"));

	            list.add(r);
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;
	}
	}