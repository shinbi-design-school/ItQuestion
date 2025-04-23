package bean;

public class User implements java.io.Serializable {

	private int user_id;
	private String username;
	private String password;
	private int score;
	
	public int getUser_Id() {
		return user_id;
	}
	public String getUsername() {
		return username;
	}
	public String getPassword() {
		return password;
	}
	public int getScore() {
		return score;
	}
	
	public void setUser_Id(int user_id) {
		this.user_id=user_id;
	}
	public void setUsername(String username) {
		this.username=username;
	}
	public void setPassword(String password) {
		this.password=password;
	}
	public void setScore(int score) {
		this.score=score;
	}
	
}
