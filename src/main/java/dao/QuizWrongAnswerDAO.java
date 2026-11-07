package dao;

import entity.QuizWrongAnswer;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class QuizWrongAnswerDAO {

    public void insert(QuizWrongAnswer wrong) {

        String sql = """
            INSERT INTO QuizWrongAnswer
            (
                result_id,
                question_text,
                correct_answer,
                user_answer
            )
            VALUES (?,?,?,?)
        """;

        try (
                Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, wrong.getResultId());
            ps.setString(2, wrong.getQuestionText());
            ps.setString(3, wrong.getCorrectAnswer());
            ps.setString(4, wrong.getUserAnswer());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}