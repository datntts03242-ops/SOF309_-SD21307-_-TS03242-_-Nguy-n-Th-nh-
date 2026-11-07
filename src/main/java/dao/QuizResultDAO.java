package dao;

import entity.QuizResult;
import utils.DBContext;

import java.sql.*;

public class QuizResultDAO {

    public int insert(QuizResult result){

        String sql="""
            INSERT INTO QuizResult
            (
                user_id,
                difficulty,
                total_question,
                correct_count,
                wrong_count,
                score,
                percentage
            )
            VALUES(?,?,?,?,?,?,?)
        """;

        try(
                Connection conn=DBContext.getConnection();
                PreparedStatement ps=
                        conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)
        ){

            ps.setInt(1,result.getUserId());
            ps.setInt(2,result.getDifficulty());
            ps.setInt(3,result.getTotalQuestion());
            ps.setInt(4,result.getCorrectCount());
            ps.setInt(5,result.getWrongCount());
            ps.setInt(6,result.getScore());
            ps.setDouble(7,result.getPercentage());

            ps.executeUpdate();

            ResultSet rs=ps.getGeneratedKeys();

            if(rs.next()){
                return rs.getInt(1);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return -1;
    }

}