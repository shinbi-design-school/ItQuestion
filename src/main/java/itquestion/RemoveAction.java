package itquestion;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UserDAO;
import dao.User_AnswerDAO;
import tool.Action;

public class RemoveAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Integer user_Id = (Integer) session.getAttribute("user_id");

        if (user_Id != null) {
            UserDAO userDAO = new UserDAO();
            int latestScore = userDAO.getNowScore(user_Id); // **修正後のメソッドを使用**
            
            User_AnswerDAO userAnswerDAO = new User_AnswerDAO();
            userAnswerDAO.deleteByUser_Answer(user_Id); // **ユーザーの回答データを削除**

            userDAO.updateScore(user_Id, latestScore); // **スコア更新**
        }

        return "frame.jsp";
    }
}