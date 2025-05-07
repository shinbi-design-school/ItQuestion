<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ログアウト完了 | ITクイズゲーム</title>
  <link rel="stylesheet" href="../css/style.css">
</head>
<script>
window.addEventListener('click', () => {
  console.log('login.jspでクリック→親にBGM開始命令');
  if (parent && typeof parent.startBGMIfNeeded === 'function') {
    parent.startBGMIfNeeded();
  }
});
</script>
<body>

  <div class="matrix-bg">
    <div class="matrix-line" style="left: 10%; animation-delay: 0s;"></div>
    <div class="matrix-line" style="left: 30%; animation-delay: 0.5s;"></div>
    <div class="matrix-line" style="left: 50%; animation-delay: 1s;"></div>
    <div class="matrix-line" style="left: 70%; animation-delay: 1.5s;"></div>
    <div class="matrix-line" style="left: 90%; animation-delay: 2s;"></div>
  </div>

  <div class="container">
  <h1>ログアウトしました</h1>
  <p>ご利用ありがとうございました。</p>
  <button class="btn" onclick="parent.mainFrame.location.href='top.jsp'">トップに戻る</button>
  </div>

</body>
</html>
