package bean;

public class User implements java.io.Serializable {

	private int id;
	private String username;
	private String password;
	private int score;
	
	public int getId() {
		return id;
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
	
	public void setId(int id) {
		this.id=id;
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
