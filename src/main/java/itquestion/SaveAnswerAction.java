package itquestion;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.QuestionDAO;
import dao.User_AnswerDAO;
import tool.Action;

public class SaveAnswerAction extends Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        System.out.println("✅ SaveAnswerAction 起動");

        HttpSession session = request.getSession();
        Integer userIdObj = (Integer) session.getAttribute("userId");
        int userId = (userIdObj != null) ? userIdObj : 0;

        // パラメータ取得
        int questionId = Integer.parseInt(request.getParameter("question_id"));
        int selectedOption = Integer.parseInt(request.getParameter("selected_option"));

        // 正解の選択肢をDBから取得
        QuestionDAO qDao = new QuestionDAO();
        int correctOption = qDao.getCorrectOption(questionId);

        // 正誤判定（選択肢が正解と一致しているか）
        boolean isCorrect = (selectedOption == correctOption);

        // ログ出力
        System.out.printf("▶ 判定：選択肢=%d, 正解=%d → %s%n",
                          selectedOption, correctOption, isCorrect ? "正解！" : "不正解");

        // DBに保存
        User_AnswerDAO dao = new User_AnswerDAO();
        dao.insertAnswer(userId, questionId, selectedOption, isCorrect);

        return null; // Ajax通信のため、画面遷移なし
    }
}
