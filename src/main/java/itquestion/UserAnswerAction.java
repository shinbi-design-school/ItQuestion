package itquestion;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Question;
import bean.User_Answer;
import tool.Action;

public class UserAnswerAction extends Action {
	
	@SuppressWarnings("uncheched")
	public String execute(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		HttpSession session=request.getSession();
		
		int question_id=Integer.parseInt(request.getParameter("question_id"));
		
		List<User_Answer> answer=(List<User_Answer>)session.getAttribute("answer");
		if (answer==null) {
			answer=new ArrayList<User_Answer>();
			session.setAttribute("answer", answer);
		}
				
		List<Question> list=(List<Question>)session.getAttribute("list");
		for(Question q : list) {
			if(q.getQuestion_Id()==question_id) {
				User_Answer ua=new User_Answer();
				ua.setQuestion(q);
				answer.add(ua);
			}
		}
		return "answer.jsp";
	}

}
