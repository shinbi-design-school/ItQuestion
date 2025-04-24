package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
			ua.setIs_Correct(rs.getBoolean("Is_Correct"));
			list.add(ua);
		}
		
		st.close();
		con.close();
		
		return list;
	}
	
	public int insert(User_Answer user_answer)throws Exception{
		Connection con =getConnection();
		
		PreparedStatement st = con.prepareStatement("insert into user_answer(id, user_id, question_id, selected_option, is_correct) values(?,?,?,?,?)");
		st.setInt(1, user_answer.getId());
		st.setInt(2, user_answer.getUser_Id());
		st.setInt(3, user_answer.getQuestion_Id());
		st.setInt(4, user_answer.getSelected_Option());
		st.setBoolean(5, user_answer.getIs_Correct());
		int line = st.executeUpdate();
		
		st.close();
		con.close();
		
		return line;
	}
	
	
	
}
