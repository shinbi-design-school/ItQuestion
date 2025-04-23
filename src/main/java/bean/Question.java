package bean;

public class Question implements java.io.Serializable {

	private int id;
	private String question;
	private String option1;
	private String option2;
	private String option3;
	private String option4;
	private int correct_option;
	private String hint;
	private String description;
	
	public Question(int id, String question, String option1, String option2, String option3, String option4, int correct_option, String hint, String description) {
		this.id=id;
		this.question=question;
		this.option1=option1;
		this.option2=option2;
		this.option3=option3;
		this.option4=option4;
		this.correct_option=correct_option;
		this.hint=hint;
		this.description=description;
	}
	
	public int getId() {
		return id;
	}
	public String getQuestion() {
		return question;
	}
	public String getOption1() {
		return option1;
	}
	public String getOption2() {
		return option2;
	}
	public String getOption3() {
		return option3;
	}
	public String getOption4() {
		return option4;
	}
	public int getCorrectOption() {
		return correct_option;
	}
	public String getHint() {
		return hint;
	}
	public String getDescription() {
		return description;
	}
	
	public void setId(int id) {
		this.id=id;
	}
	public void setQuestion(String question) {
		this.question=question;
	}
	public void setOption1(String option1) {
		this.option1=option1;
	}
	public void setOption2(String option2) {
		this.option2=option2;
	}
	public void setOption3(String option3) {
		this.option3=option3;
	}
	public void setOption4(String option4) {
		this.option4=option4;
	}
	public void setCorrectOption(int correct_option) {
		this.correct_option=correct_option;
	}
	public void setHint(String hint) {
		this.hint=hint;
	}
	public void setDescription(String description) {
		this.description=description;
	}
	
}
