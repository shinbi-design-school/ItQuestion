package itquestion;

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
		
		UserDAO dao=new UserDAO();
		User user=dao.search(username,password);
		
		if(user != null) {
			  session.setAttribute("username", user.getUsername());
			  session.setAttribute("userId", user.getUser_Id());  // ← これで保存OKになる！
			  return "top.jsp";
			}
		
		return "login-error.jsp";
	}
	

}
