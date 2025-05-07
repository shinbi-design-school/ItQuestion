<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>登録成功 | アイティークイズゲーム</title>
  <link rel="stylesheet" href="/itquestion/css/style.css">
  <script src="/itquestion/js/sound.js"></script>
  <style>
    .footer {
      position: fixed;
      bottom: 10px;
      width: 100%;
      text-align: center;
      color: #00f0ff;
    }
  </style>
</head>
<body>

<script>
window.addEventListener('click', () => {
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
  <h1>登録完了！</h1>
  <p style="color: #00f0ff;">新規ユーザー登録が正常に完了しました。</p>

  <button class="btn" onclick="parent.mainFrame.location.href='login.jsp'">ログイン画面に進む</button>

</div>

<div class="footer">© 2025 IT Quiz Project</div>
</body>
</html>
