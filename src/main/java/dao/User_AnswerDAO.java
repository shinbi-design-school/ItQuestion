package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import bean.Question;
import bean.User_Answer;

public class User_AnswerDAO extends DAO {

	public List<User_Answer> search(String answer) throws Exception{
		List<User_Answer> list= new ArrayList<>();
		
		Connection con = getConnection();
		
		PreparedStatement st=con.prepareStatement("select * from user_answer where user_id like ?");
		st.setString(1, "%"+answer+"%");
		ResultSet rs=st.executeQuery();
		
		while(rs.next()) {
			User_Answer ua= new User_Answer();
			ua.setId(rs.getInt("id"));
			ua.setUser_Id(rs.getInt("user_id"));
			ua.setQuestion_Id(rs.getInt("question_id"));
			ua.setSelected_Option(rs.getInt("selected_option"));
			ua.setIs_correct(rs.getBoolean("Is_correct"));
			list.add(ua);
		}
		
		st.close();
		con.close();
		
		return list;
	}
	
	public void insertAnswer(int userId, int questionId, int selectedOption, int isCorrect) throws Exception {
		  String sql = "INSERT INTO user_answer (user_id, question_id, selected_option, is_correct, now_score) VALUES (?, ?, ?, ?, ?)";
		  try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
		    stmt.setInt(1, userId);
		    stmt.setInt(2, questionId);
		    stmt.setInt(3, selectedOption);
		    stmt.setInt(4, isCorrect);
		    stmt.setInt(5, isCorrect == 1 ? 5 : 0); // 正解なら5点、間違いは0点
		    
		    int rows = stmt.executeUpdate(); // ← ★これが必要
		    System.out.println("✅ DB保存成功（行数: " + rows + "）");

		  } catch (Exception e) {
		    System.out.println("❌ DB保存失敗！");
		    e.printStackTrace();
		  }
		}
	
	public List<User_Answer> getResult() throws Exception {
	    List<User_Answer> resultList = new ArrayList<>();
	    String query = "SELECT q.question, ua.is_correct, q.description, q.option1, q.option2, q.option3, q.option4, q.correct_option FROM User_Answer ua JOIN Question q ON ua.question_id = q.question_id;";

	    try (Connection con = getConnection();
	         PreparedStatement stmt = con.prepareStatement(query);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            // Questionオブジェクトの作成
	            Question question = new Question();
	            question.setQuestion(rs.getString("question"));
	            question.setDescription(rs.getString("description"));

	            // User_Answerオブジェクトの作成
	            User_Answer user_answer = new User_Answer();
	            user_answer.setIs_correct(rs.getBoolean("is_correct"));
	            user_answer.setQuestion(question); // Questionをセット

	            // correct_optionを取得
	            int correctIndex = rs.getInt("correct_option");

	            // 選択肢のリストを作成
	            List<String> options = Arrays.asList(
	                rs.getString("option1"),
	                rs.getString("option2"),
	                rs.getString("option3"),
	                rs.getString("option4")
	            );

	            // 正解のオプションを取得
	            if (correctIndex >= 1 && correctIndex <= 4) { // correct_optionは1～4と仮定
	                String correctOptionText = options.get(correctIndex - 1); // Javaのリストは0-indexなので調整
	                System.out.println("正解のオプション: " + correctOptionText);

	                // 必要に応じてQuestionにセット（例）
	                question.setCorrectOption(correctIndex);
	            }

	            // リストに追加
	            resultList.add(user_answer);
	        }

	        System.out.println("取得したリザルトのリスト: " + resultList);

	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("リザルト取得時のエラー: " + e.getMessage());
	    }

	    return resultList;
	}
	
	public int deleteByUser_Answer(int user_Id) throws Exception {
        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement("DELETE FROM user_answer WHERE user_id = ?");
        st.setInt(1, user_Id);

        int affectedRows = st.executeUpdate();

        st.close();
        con.close();

        return affectedRows;	//カラムごと削除
    }

}


	

