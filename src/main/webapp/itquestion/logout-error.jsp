<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ログアウトエラー | ITクイズゲーム</title>
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
    <h1>ログアウトできませんでした</h1>
    <p>セッションがすでに切れている可能性があります。</p>
    <button class="btn" onclick="location.href='login.jsp'">ログイン画面に戻る</button>
  </div>
</body>
</html>

