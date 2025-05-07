package itquestion;

import java.security.MessageDigest;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.User;
import dao.UserDAO;
import tool.Action;

public class LoginAction extends Action {
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();

        String username = request.getParameter("username");
        String rawPassword = request.getParameter("password");

        // パスワードをSHA-256でハッシュ化
        String hashedPassword = hashPassword(rawPassword);

        UserDAO dao = new UserDAO();
        User user = dao.search(username, hashedPassword);

        if (user != null) {
            session.setAttribute("username", user.getUsername());
            session.setAttribute("userId", user.getUser_Id());
            return "top.jsp";
        }

        return "login-error.jsp";
    }

    // SHA-256 ハッシュ関数
    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = md.digest(password.getBytes("UTF-8"));

        StringBuilder sb = new StringBuilder();
        for (byte b : hashBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
