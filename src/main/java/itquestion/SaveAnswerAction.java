package itquestion;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.User_AnswerDAO;
import tool.Action;

public class SaveAnswerAction extends Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	  
	  System.out.println("SaveAnswerAction 起動"); //4/30追加
    // ユーザーIDをセッションから取得（ゲストの場合は仮ID）
    Integer userId = (Integer) request.getSession().getAttribute("userId");
    if (userId == null) {
      userId = -1; // ゲストプレイなどの場合
    }

    // パラメータ取得（JavaScriptから送信されたデータ）
    int questionId = Integer.parseInt(request.getParameter("question_id"));
    int selectedOption = Integer.parseInt(request.getParameter("selected_option"));
    int isCorrect = Integer.parseInt(request.getParameter("is_correct"));

    // 回答をDBに保存
    User_AnswerDAO dao = new User_AnswerDAO();
    dao.insertAnswer(userId, questionId, selectedOption, isCorrect);

    return null; // 戻り値なし（Ajax通信なのでOK）
  }
}
