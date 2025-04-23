package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.User;

public class UserDAO extends DAO{
	public User search(String username, String password, int score)throws Exception{
		User user=null;
		
		Connection con=getConnection();
		
		PreparedStatement st;
		st=con.prepareStatement(
				"select * from user where username=? and password=? and score=?");
		st.setString(1, username);
		st.setString(2, password);
		st.setInt(3, score);
		ResultSet rs=st.executeQuery();
		
		while(rs.next()) {
			user=new User();
			user.setId(rs.getInt("id"));
			user.setUsername(rs.getString("username"));
			user.setPassword(rs.getString("password"));
			user.setScore(rs.getInt("score"));
		}
		st.close();
		con.close();
		return user;
	}

}
