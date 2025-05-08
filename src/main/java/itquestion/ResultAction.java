package itquestion;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.User_Answer;
import dao.UserDAO;
import dao.User_AnswerDAO;
import tool.Action;

public class ResultAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<User_Answer> resultList = new ArrayList<>();
        HttpSession session = request.getSession();

        try {
            // セッションからuser_idを取得
            Integer userIdObj = (Integer) session.getAttribute("userId");

            if (userIdObj != null) {
                int userId = userIdObj;

                // User_AnswerDAOにuser_idを渡して結果を取得
                User_AnswerDAO user_answerDAO = new User_AnswerDAO();
                resultList = user_answerDAO.getResult(userId); // 修正されたgetResultメソッドを呼び出し
                System.out.println("ResultActionで取得したリザルトリスト: " + resultList);

            } else {
                // ログインしていない場合
                request.setAttribute("error", "ユーザーがログインしていません。");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "リザルト取得中にエラーが発生しました。");
        }

        // リザルトリストをセッションにセット
        session.setAttribute("resultList", resultList);
        System.out.println("セッションにセットしたリザルトリスト: " + session.getAttribute("resultList"));

        // userId がセッションにあるか（ログインしているか）を確認
        Integer userIdObj = (Integer) session.getAttribute("userId");

        if (userIdObj != null) {
            // ログインユーザー → スコアをDB更新
            int userId = userIdObj;

            UserDAO userDAO = new UserDAO();
            int latestScore = userDAO.getNowScore(userId);
            if (latestScore < 101) {
                userDAO.updateScore(userId, latestScore);
                session.setAttribute("score", latestScore);
            } else {
                System.out.println("スコアが101以上のため、更新しません: " + latestScore);
                session.setAttribute("score", latestScore); // 表示だけはする
            }


        } else {
            // ゲスト → スコアを自前で集計（保存はしない）
            int guestScore = 0;
            for (User_Answer ua : resultList) {
                if (ua.getIs_correct()) {
                    guestScore += 5;
                }
            }
            session.setAttribute("score", guestScore);
            System.out.println("ゲストモード：スコア表示のみ：" + guestScore);
        }

        return "result.jsp"; // 結果ページへ遷移
    }
}
