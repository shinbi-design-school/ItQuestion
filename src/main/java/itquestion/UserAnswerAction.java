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

    @SuppressWarnings("unchecked")
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();

        int question_id = Integer.parseInt(request.getParameter("question_id"));

        // userIdをセッションから取得（ゲストなら0）
        Integer userIdObj = (Integer) session.getAttribute("userId");
        int userId = (userIdObj != null) ? userIdObj : 0;

        // 回答リスト取得 or 新規作成
        List<User_Answer> answer = (List<User_Answer>) session.getAttribute("answer");
        if (answer == null) {
            answer = new ArrayList<User_Answer>();
            session.setAttribute("answer", answer);
        }

        // 問題リスト取得
        List<Question> list = (List<Question>) session.getAttribute("list");
        for (Question q : list) {
            if (q.getQuestion_Id() == question_id) {
                User_Answer ua = new User_Answer();
                ua.setUser_Id(userId);              // ← user_id を設定（重要）
                ua.setQuestion_Id(q.getQuestion_Id());
                ua.setQuestion(q);
                // ここで selected_option や is_correct の設定が別に行われているなら省略
                answer.add(ua);
            }
        }

        return "answer.jsp";
    }
}
