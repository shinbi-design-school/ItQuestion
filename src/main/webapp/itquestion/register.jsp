<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>新規登録 | アイティークイズゲーム</title>
  <link rel="stylesheet" href="/itquestion/css/style.css">
  <script src="/itquestion/js/sound.js"></script>
  <style>
    input[type="text"],
    input[type="password"] {
      font-size: 1.2em;
      padding: 8px;
      width: 250px;
    }

    .footer {
      position: fixed;
      bottom: 10px;
      width: 100%;
      text-align: center;
      color: #00f0ff;
    }

    form {
      margin-bottom: 20px;
    }

    label {
      color: #00f0ff;
      font-size: 1.1em;
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
  <h1>新規ユーザー登録</h1>

  <% String error = request.getParameter("error"); %>
  <% if ("duplicate".equals(error)) { %>
    <p style="color: red;">※ そのユーザー名はすでに使われています。</p>
  <% } %>

  <form action="UserAdd.action" method="post">
    <label>ユーザー名:</label><br>
    <input type="text" name="username" required><br><br>

    <label>パスワード:</label><br>
    <input type="password" name="password" required><br><br>

    <input class="btn" type="submit" value="登録する">
  </form>

  <button class="btn" onclick="parent.mainFrame.location.href='login.jsp'">ログイン画面に戻る</button>
</div>

<div class="footer">© 2025 IT Quiz Project</div>
</body>
</html>
