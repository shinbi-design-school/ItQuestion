package itquestion;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import tool.Action;

public class GuestStartAction extends Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        // ゲストユーザーとしてセッションに情報を保存
        session.setAttribute("username", "guest");
        session.setAttribute("userId", 9);  // ← 重要！

        System.out.println("▶ ゲストユーザーとしてセッション開始（userId=9）");

        return "Mondai.action";  // ゲストも通常ユーザーと同じトップ画面へ
    }
}

