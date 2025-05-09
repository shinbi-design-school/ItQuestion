package itquestion;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Question;
import dao.QuestionDAO;
import dao.User_AnswerDAO;
import tool.Action;

public class MondaiAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        User_AnswerDAO userAnswerDAO = new User_AnswerDAO();

        if (userId != null) {
        	System.out.println("▶ ユーザーID " + userId + " の回答履歴を削除しました。");
            int rows = userAnswerDAO.deleteByUser_Answer(userId);
            System.out.println("▶ 削除された行数: " + rows);
            // ログインユーザー → 該当ユーザーの回答履歴のみ削除
            userAnswerDAO.deleteByUser_Answer(userId);
            
        } else {
            // ゲスト → 全件削除（注意：他のユーザー分も消える）
            userAnswerDAO.deleteAll();
            System.out.println("▶ ゲストプレイ：useranswerテーブル全件削除しました。");
        }

        // DBから20問ランダムに取得
        QuestionDAO qDao = new QuestionDAO();
        List<Question> questionList = qDao.getRandomQuestions(20);

        // 問題リストをリクエストスコープにセット
        request.setAttribute("questionList", questionList);

        // mondai.jsp へ遷移
        return "mondai.jsp";
    }
}
