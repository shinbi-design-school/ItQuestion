<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    boolean isLoggedIn = (username != null);
%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>トップ | アイティークイズゲーム</title>
  <link rel="stylesheet" href="/itquestion/css/style.css">
  
  <script src="/itquestion/js/sound.js"></script>




  
</head>
<body>

<script>
window.addEventListener('click', () => {
  console.log('top.jspでクリック→親にBGM開始命令');
  if (parent && typeof parent.startBGMIfNeeded === 'function') {
    parent.startBGMIfNeeded();
  }
});
</script>



  <div class="matrix-bg">
    <div class="matrix-line" style="left: 10%; animation-delay: 0s;"></div>
    <div class="matrix-line" style="left: 30%; animation-delay: 0.5s;"></div>
    <div class="matrix-line" style="left: 50%; animation-delay: 1s;"></div>
    <div class="matrix-line" style="left: 70%; animation-delay: 1.5s;"></div>
    <div class="matrix-line" style="left: 90%; animation-delay: 2s;"></div>
  </div>

  <div class="container">
    <%-- ユーザー表示バー --%>
    <div style="position: absolute; top: 10px; left: 20px; color: #00f0ff;">
      <% if (isLoggedIn) { %>
        ようこそ、<%= username %>さん |
        <a href="Logout.action" style="color: #00f0ff; text-decoration: underline;">ログアウト</a>
      <% } else { %>
        ようこそ、ゲストさん
      <% } %>
    </div>

    <% if (isLoggedIn) { %>
  <h1>クイズ</h1>
  <button class="btn" onclick="parent.mainFrame.location.href='Mondai.action'">スタート</button>
	<% } else { %>
  <h1>アイティークイズゲーム</h1>
  <button class="btn" onclick="parent.mainFrame.location.href='login.jsp'">ログイン</button>
  <button class="btn" onclick="parent.mainFrame.location.href='register.jsp'">新規登録</button>
  
   <button type="button" class="btn btn-guest" onclick="parent.mainFrame.location.href='GuestStart.action'">
 			ゲストモードで遊ぶ
   </button>
  <button class="btn" onclick="parent.mainFrame.location.href='Ranking.action'">ランキングを見る</button>
	<% } %>


    <div class="footer">© 2025 IT Quiz Project</div>
  </div>



</body>
</html>
