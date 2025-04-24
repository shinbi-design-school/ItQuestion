<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>トップ | アイティークイズゲーム</title>
  <link rel="stylesheet" href="../css/style.css">
</head>
<body>
  <div class="matrix-bg">
    <div class="matrix-line" style="left: 10%; animation-delay: 0s;"></div>
    <div class="matrix-line" style="left: 30%; animation-delay: 0.5s;"></div>
    <div class="matrix-line" style="left: 50%; animation-delay: 1s;"></div>
    <div class="matrix-line" style="left: 70%; animation-delay: 1.5s;"></div>
    <div class="matrix-line" style="left: 90%; animation-delay: 2s;"></div>
  </div>

  <div class="container">
    <% if (username != null) { %>
      <div style="position: absolute; top: 10px; left: 20px; color: #00f0ff;">
        ようこそ、<%= username %>さん
      </div>
      <h1>クイズ</h1>
      <button class="btn" onclick="location.href='mondai.jsp'">スタート</button>
    <% } else { %>
      <h1>アイティークイズゲーム</h1>
      <button class="btn" onclick="location.href='login.jsp'">ログイン</button>
      <button class="btn btn-guest" onclick="location.href='mondai.html'">ゲストモードで遊ぶ</button>
      <button class="btn" onclick="location.href='ranking.jsp'">ランキングを見る</button>
    <% } %>
    <div class="footer">© 2025 IT Quiz Project</div>
  </div>
</body>
</html>