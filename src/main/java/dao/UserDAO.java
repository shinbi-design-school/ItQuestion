package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.User;

public class UserDAO extends DAO{
	public User search(String username, String password)throws Exception{
		User user=null;
		
		Connection con=getConnection();
		
		PreparedStatement st;
		st=con.prepareStatement(
				"select * from user where username=? and password=?");
		st.setString(1, username);
		st.setString(2, password);
	
		ResultSet rs=st.executeQuery();
		
		while(rs.next()) {
			user=new User();
			user.setUser_Id(rs.getInt("user_id"));
			user.setUsername(rs.getString("username"));
			user.setPassword(rs.getString("password"));
			user.setScore(rs.getInt("score"));
		}
		st.close();
		con.close();
		return user;
	}
	public User search(String username, String password, int score) throws Exception {
        String query = "SELECT * FROM user WHERE username=? AND password=? AND score=?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(query)) {
            st.setString(1, username);
            st.setString(2, password);
            st.setInt(3, score);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"), rs.getInt("score"));
                }
            }
        }
        return null;
    }
	
	// 最新スコア取得
    public int getNowScore(int userId) throws Exception {
        String query = "SELECT SUM(now_score) FROM User_Answer WHERE user_id = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(query)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0; // ユーザーごとのスコア合計を取得
            }
        }
    }
    // ランキング取得
 // ランキング取得（ゲストuser_id=9を除外）
    public List<User> getRanking() throws Exception {
        List<User> rankingList = new ArrayList<>();
        String query = "SELECT user_id, username, score FROM User WHERE user_id != 9 ORDER BY score DESC LIMIT 10";

        try (Connection con = getConnection();
             PreparedStatement stmt = con.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User(rs.getInt("user_id"), rs.getString("username"), "", rs.getInt("score"));
                rankingList.add(user);
            }

            System.out.println("取得したランキングリスト（ゲスト除外済）: " + rankingList);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ランキング取得時のエラー: " + e.getMessage());
        }

        return rankingList;
    }

 // スコア更新
    public void updateScore(int userId, int newScore) throws Exception {
        String query = "UPDATE User SET score = ? WHERE user_id = ? AND score < ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(query)) {
            st.setInt(1, newScore);
            st.setInt(2, userId);
            st.setInt(3, newScore);
            int updatedRows = st.executeUpdate();
            System.out.println("スコア更新: " + updatedRows + "件");
        }
    }
    public boolean insert(User user) throws Exception {
        // 重複チェックSQL
        String checkSql = "SELECT COUNT(*) FROM USER WHERE username = ?";
        // 登録SQL
        String insertSql = "INSERT INTO USER (username, password) VALUES (?, ?)";

        try (Connection con = getConnection()) {
            // ① ユーザー名の重複を確認
            try (PreparedStatement checkStmt = con.prepareStatement(checkSql)) {
                checkStmt.setString(1, user.getUsername());
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;  // ユーザー名がすでに存在
                }
            }

            // ② 新規登録
            try (PreparedStatement insertStmt = con.prepareStatement(insertSql)) {
                insertStmt.setString(1, user.getUsername());
                insertStmt.setString(2, user.getPassword()); // ハッシュ済み
                int rows = insertStmt.executeUpdate();
                return rows > 0;
            }
        }
    }


}
