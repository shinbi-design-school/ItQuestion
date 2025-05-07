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
        // セッションからuserIdを取得
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // userIdがあればDB処理を実行
        if (userId != null) {
            UserDAO userDAO = new UserDAO();
            int latestScore = userDAO.getNowScore(userId);  // 最新スコア取得

            User_AnswerDAO userAnswerDAO = new User_AnswerDAO();
            userAnswerDAO.deleteByUser_Answer(userId);      // 回答履歴削除

            userDAO.updateScore(userId, latestScore);       // スコア更新
        }

        // レスポンスにJavaScriptを書き込み：mainFrameをtop.jspに遷移させ、BGMも切り替え
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html><head><title>Redirecting...</title></head><body>");
        response.getWriter().println("<script>");
        response.getWriter().println("if (parent && parent.changeBGM) {");
        response.getWriter().println("  parent.changeBGM('/itquestion/sound/start.mp3');");
        response.getWriter().println("}");
        response.getWriter().println("if (parent && parent.mainFrame) {");
        response.getWriter().println("  parent.mainFrame.location.href = 'top.jsp';");
        response.getWriter().println("}");
        response.getWriter().println("</script>");
        response.getWriter().println("</body></html>");

        return null; // すでにレスポンスを書いているのでreturn不要
    }
}
