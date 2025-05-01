package itquestion;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.User;
import dao.UserDAO;
import tool.Action;

public class RankingAction extends Action {
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    
		List<User> rankingList = new ArrayList<>();
	    HttpSession session = request.getSession();
	    
	    try {
	        UserDAO userDAO = new UserDAO();
	        rankingList = userDAO.getRanking(); 
	        
	        System.out.println("RankingActionで取得したランキングリスト: " + rankingList);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("error", "ランキング取得中にエラーが発生しました。");
	    }

	    session.setAttribute("rankingList", rankingList);
	    System.out.println("セッションにセットしたランキングリスト: " + session.getAttribute("rankingList")); // 追加
	    return "ranking.jsp";
	}
	/*
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<User> rankingList = new ArrayList<>();
        HttpSession session = request.getSession();

        try {
            UserDAO userDAO = new UserDAO();
            rankingList = userDAO.getRanking(); 
            
            // 取得結果をログ出力
            System.out.println("RankingAction 実行開始");
            System.out.println("ランキングリスト: " + rankingList);
            System.out.println("セッションにセット前のランキングリストのサイズ: " + rankingList.size());
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "ランキング取得中にエラーが発生しました。");
        }

        session.setAttribute("rankingList", rankingList);
        return "ranking.jsp";
    }
    
    */
    
}



/*
public class RankingAction extends Action {
    public RankingAction() throws Exception {
        super();
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<User> rankingList = new ArrayList<>(); // 空のリストで初期化

        try (Connection connection = getConnection()) {
            if (connection != null) {
                UserDAO userDAO = new UserDAO(connection);
                rankingList = userDAO.getRanking();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        session.setAttribute("rankingList", rankingList); // JSPに渡す

        return "ranking.jsp"; // リダイレクト先を返す
    }

    private Connection getConnection() throws Exception {
        return (dataSource != null) ? dataSource.getConnection() : null; // Nullチェックを追加
    }
}
*/



/*
public class RankingAction extends Action {
    public RankingAction() throws Exception {
        super();
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try (Connection connection = getConnection()) { // Connection の管理を適切に
            UserDAO userDAO = new UserDAO(connection);
            List<User> rankingList = userDAO.getRanking(); // ランキング取得

            if (rankingList != null && !rankingList.isEmpty()) { // Null チェックを追加
                HttpSession session = request.getSession();
                session.setAttribute("rankingList", rankingList); // JSPに渡す
            }
        }

        return "ranking.jsp"; // リダイレクト先を返す
    }

    private Connection getConnection() throws Exception {
        return dataSource.getConnection(); // `Action` のフィールドを活用
    }
}
*/

/*
public class RankingAction extends Action {
    public RankingAction() throws Exception {
        super();
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        UserDAO userDAO = new UserDAO(dataSource.getConnection()); // `DataSource` を利用する
        List<User> rankingList = userDAO.getRanking(); // ランキング取得

        HttpSession session = request.getSession();
        session.setAttribute("rankingList", rankingList); // JSPに渡す

        return "ranking.jsp"; // リダイレクト先を返す
    }
}

*/