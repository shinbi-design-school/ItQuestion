package itquestion;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.User_Answer;
import dao.User_AnswerDAO;
import tool.Action;

public class ResultAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		List<User_Answer> resultList = new ArrayList<>();
	    HttpSession session = request.getSession();
	    
	    try {
	        User_AnswerDAO user_answerDAO = new User_AnswerDAO();
	        resultList = user_answerDAO.getResult(); 
	        
	        System.out.println("RankingActionで取得したランキングリスト: " + resultList);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("error", "ランキング取得中にエラーが発生しました。");
	    }

	    session.setAttribute("resultList", resultList);
	    System.out.println("セッションにセットしたランキングリスト: " + session.getAttribute("resultList")); // 追加
	    return "result.jsp";
	}
	
}
