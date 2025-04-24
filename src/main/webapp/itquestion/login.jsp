<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ログイン | アイティークイズゲーム</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Share Tech Mono', monospace;
      background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
      color: #00f0ff;
      height: 100vh;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .matrix-bg {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 0;
      overflow: hidden;
    }

    .matrix-line {
      position: absolute;
      width: 2px;
      height: 100%;
      background: rgba(0, 255, 0, 0.1);
      animation: fall 2s linear infinite;
    }

    @keyframes fall {
      0% { transform: translateY(-100%); }
      100% { transform: translateY(100%); }
    }

    .container {
      position: relative;
      text-align: center;
      padding: 40px;
      background-color: rgba(0, 0, 0, 0.8);
      border-radius: 12px;
      box-shadow: 0 0 30px #00f0ff;
      width: 90%;
      max-width: 500px;
      z-index: 1;
    }

    h1 {
      font-size: 32px;
      margin-bottom: 30px;
      color: #00f0ff;
      text-shadow: 0 0 10px #00f0ff;
    }

    .btn {
      display: block;
      margin: 15px auto;
      padding: 15px 25px;
      font-size: 18px;
      font-weight: bold;
      color: #0f0f0f;
      background-color: #00f0ff;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      max-width: 300px;
      transition: all 0.3s ease;
      box-shadow: 0 0 10px #00f0ff;
    }

    .btn:hover {
      background-color: #00d5e2;
      box-shadow: 0 0 20px #00eaff;
    }

    .btn-guest {
      background-color: transparent;
      color: #00f0ff;
      border: 2px solid #00f0ff;
    }

    .btn-guest:hover {
      background-color: #001f1f;
    }

    label {
      display: block;
      text-align: left;
      margin: 10px 0 5px;
    }

    input {
      width: 100%;
      padding: 12px;
      border-radius: 6px;
      border: none;
      font-size: 16px;
      font-family: 'Share Tech Mono', monospace;
    }

    .error {
      color: red;
      font-size: 14px;
      margin-top: 10px;
    }
  </style>
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
    <h1>ログイン</h1>
    <form id="loginForm" action="LoginServlet" method="post" onsubmit="return validateForm()">
      <label for="username">ユーザー名</label>
      <input type="text" id="username" name="username" placeholder="ユーザー名">

      <label for="password">パスワード</label>
      <input type="password" id="password" name="password" placeholder="パスワード">

      <div id="errorMsg" class="error"></div>

      <button type="submit" class="btn">ログイン</button>
      <button type="button" class="btn btn-guest" onclick="location.href='mondai.jsp'">ゲストモードで遊ぶ</button>
    </form>
  </div>

  <script>
    function validateForm() {
      const username = document.getElementById('username').value.trim();
      const password = document.getElementById('password').value.trim();
      const errorMsg = document.getElementById('errorMsg');

      if (username === "" || password === "") {
        errorMsg.textContent = "ユーザー名とパスワードを入力してください。";
        return false;
      }

      return true;
    }
  </script>
</body>
</html>