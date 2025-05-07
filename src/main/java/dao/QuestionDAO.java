package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Question;


public class QuestionDAO extends DAO {  

    public QuestionDAO() {
        super();  
    }
    
 
    public List<Question> getRandomQuestions(int limit) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM QUESTION ORDER BY RAND() LIMIT ?"; // ★固定値→プレースホルダに

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, limit); // ★ここで実際の数を指定（例：20）

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question(
                        rs.getInt("question_id"),
                        rs.getString("question"),
                        rs.getString("option1"),
                        rs.getString("option2"),
                        rs.getString("option3"),
                        rs.getString("option4"),
                        rs.getInt("correct_option"), // ← DBと一致済み
                        rs.getString("hint"),
                        rs.getString("description")
                    );
                    questions.add(question);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }


   
    public List<Question> getAllQuestions() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM QUESTION";

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Question question = new Question(
                    rs.getInt("question_id"),
                    rs.getString("question"),
                    rs.getString("option1"),
                    rs.getString("option2"),
                    rs.getString("option3"),
                    rs.getString("option4"),
                    rs.getInt("correct_option"),
                    rs.getString("hint"),
                    rs.getString("description")
                );
                questions.add(question);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

   
    public boolean addQuestion(Question question) {
        String sql = "INSERT INTO QUESTION (question, option1, option2, option3, option4, correct_option, hint, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, question.getQuestion());
            stmt.setString(2, question.getOption1());
            stmt.setString(3, question.getOption2());
            stmt.setString(4, question.getOption3());
            stmt.setString(5, question.getOption4());
            stmt.setInt(6, question.getCorrectOption());
            stmt.setString(7, question.getHint());
            stmt.setString(8, question.getDescription());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    
    public boolean deleteQuestion(int question_id) {
        String sql = "DELETE FROM QUESTION WHERE question_id = ?";

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, question_id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getCorrectOption(int questionId) throws Exception {
        String sql = "SELECT correct_option FROM question WHERE question_id = ?";
        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("correct_option");
                } else {
                    throw new Exception("正解が見つかりません（question_id = " + questionId + "）");
                }
            }
        }
    }

}
