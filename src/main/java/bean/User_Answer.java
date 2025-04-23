package bean;

public class User_Answer {
	
	private int id;
	private int user_id;
	private int question_id;
	private int selected_option;
	private boolean is_correct;

	
	public int getId() {
		return id;
	}
	public int getUser_Id() {
		return user_id;
	}
	public int getQuestion_Id() {
		return question_id;
	}
	public int getSelected_Option() {
		return selected_option;
	}
	public boolean getIs_correct() {
		return is_correct;
	}
	

	public void setId(int id) {
		this.id=id;
	}
	public void setUser_Id(int user_id) {
		this.user_id=user_id;
	}
	public void setQuestion_Id(int question_id) {
		this.question_id=question_id;
	}
	public void setSelected_Option(int selected_option) {
		this.selected_option=selected_option;
	}
	public boolean setIs_correct(boolean is_correct) {
		return is_correct;
	}
	
}
