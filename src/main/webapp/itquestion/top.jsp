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

<style>.warning-fixed {
  position: fixed;
  top: 5%;
  left: 50%;
  transform: translateX(-50%);
  font-size: 35px;
  font-weight: bold;
  color: #ff2222;
  text-shadow: 0 0 6px #ff2222, 0 0 12px #ff2222;
  animation: glowPulse 2s ease-in-out infinite;
  z-index: 999;
}

/* 明滅アニメーション */
@keyframes glowPulse {
  0%, 100% {
    opacity: 1;
    text-shadow: 0 0 6px #ff2222, 0 0 12px #ff2222;
  }
  50% {
    opacity: 0.5;
    text-shadow: 0 0 2px #ff2222, 0 0 4px #ff2222;
  }
}


</style>

  
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

<!-- ★ 警告表示（右上固定・ぼかしなし） -->
<div class="warning-fixed">※ブラウザバック非推奨※</div>

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

<script src="/itquestion/js/sound.js"></script>
<script>
  setupSounds("/itquestion/sound/cursor.mp3", "/itquestion/sound/click.mp3");

  // top.jsp に戻ったときに start.mp3 を再生
  window.addEventListener("load", () => {
    setTimeout(() => {
      if (parent && typeof parent.changeBGM === "function") {
        parent.changeBGM("/itquestion/sound/start.mp3");
        console.log("🎵 top.jsp で BGM を start.mp3 に切り替えました");
      }
    }, 300); // autoplay制限回避のための遅延
  });
</script>

</body>
</html>
