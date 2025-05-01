package itquestion;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bean.Question;
import dao.QuestionDAO;
import tool.Action;

public class MondaiAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // QuestionDAOを使ってDBから20問ランダム取得
        QuestionDAO qDao = new QuestionDAO();
        List<Question> questionList = qDao.getRandomQuestions(20);  // ★ここで20問取得！

        // 取得した問題リストをリクエストスコープに保存
        request.setAttribute("questionList", questionList);

        // 表示するページ（mondai.jsp）へ進む
        return "mondai.jsp";
    }
}

