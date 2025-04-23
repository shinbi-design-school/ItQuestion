package ItQuestion;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.User;
import dao.UserDAO;
import tool.Action;

public class LoginAction extends Action {
	public String execute(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		HttpSession session=request.getSession();
		
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		int score=Integer.parseInt(request.getParameter("score"));
		UserDAO dao=new UserDAO();
		User user=dao.search(username,password,score);
		
		if(user!=null) {
			session.setAttribute("user", user);
			return "login-out.jsp";
		}
		
		return "login-error.jsp";
	}
	

}
