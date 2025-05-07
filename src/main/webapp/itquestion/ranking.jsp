<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ランキング | アイティークイズゲーム</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Share Tech Mono', monospace;
      background: #000;
      color: #00f0ff;
      margin: 0;
      overflow: hidden;
    }

canvas {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
}

    h1, table, .btn, .home-icon {
      position: relative;
      z-index: 2;
    }

    h1 {
      text-align: center;
      margin: 40px 0 20px;
      text-shadow: 0 0 10px #00f0ff;
    }

    table {
      width: 80%;
      margin: auto;
      border-collapse: collapse;
      background-color: rgba(0, 0, 0, 0.7);
      box-shadow: 0 0 20px #00f0ff;
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #00f0ff;
    }

    th {
      background-color: #003344;
    }

    tr:hover {
      background-color: rgba(0, 255, 255, 0.2);
    }

    .btn {
      display: block;
      margin: 30px auto 40px;
      padding: 12px 30px;
      font-size: 16px;
      font-weight: bold;
      color: #0f0f0f;
      background-color: #00f0ff;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      box-shadow: 0 0 10px #00f0ff;
      transition: all 0.3s ease;
    }

    .btn:hover {
      background-color: #00d5e2;
      box-shadow: 0 0 20px #00eaff;
    }


    .ending-icon {
  position: fixed;
  bottom: 20px;
  right: 90px; /* ← home-iconと被らないよう少し左にずらす */
  width: 56px;
  height: 56px;
  z-index: 10;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: transform 0.3s ease;
}

.ending-icon img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  transition: transform 0.3s ease;
}

.ending-icon:hover img {
  transform: scale(1.1);
}
    
  </style>
</head>
<body>
<script>
window.addEventListener("load", () => {
  setTimeout(() => {
    if (parent && typeof parent.changeBGM === "function") {
      parent.changeBGM("/itquestion/sound/ranking.mp3");
      console.log("🎵 result.jsp で BGM を ranking.mp3 に切り替えました");
    }
  }, 300); // 再生ブロック対策の遅延
});
</script>

  <canvas id="matrix"></canvas>

  <h1>ランキング</h1>
  <table>
    <tr>
      <th>順位</th>
      <th>ユーザー名</th>
      <th>スコア</th>
    </tr>
   
    <c:choose>
      <c:when test="${not empty rankingList}">
        <c:set var="rank" value="0" /> <!-- 順位カウント用変数 -->
        
      
        <c:forEach var="user" items="${rankingList}">
          <c:set var="rank" value="${rank + 1}" /> <!-- 順位をインクリメント -->
          <tr>
            <td>${rank}</td> <!-- リストの順番で順位を設定 -->
            <td>${user.username}</td> <!-- username を表示 -->
            <td>${user.score}</td> <!-- score を表示 -->
          </tr>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="3">ランキング情報がありません。</td>
        </tr>
      </c:otherwise>
    </c:choose>
  </table>
	
 	<a href="javascript:void(0);" class="ending-icon" onclick="parent.mainFrame.location.href='ending.jsp'" title="エンディングへ">
  		<img src="../image/fin2.png" alt="Fin" />
	</a>

<!--
<body>
  <canvas id="matrix"></canvas>

  <h1>ランキング</h1>
  <table>
    <tr><th>順位</th><th>ユーザー名</th><th>スコア</th></tr>
    <c:set var="rank" value="0" /> 
    <c:forEach var="user" items="${rankingList}">
      <c:set var="rank" value="${rank + 1}" /> 
      <tr>
        <td>${rank}</td> 
        <td>${user.username}</td> 
        <td>${user.score}</td>
      </tr>
    </c:forEach>
  </table>

  <a href="top.jsp" class="home-icon" title="トップへ戻る">
    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24">
      <path d="M12 3l9 8h-3v10h-4v-6H10v6H6V11H3l9-8z"/>
    </svg>
  </a>
-->


  <script>
  const canvas = document.getElementById("matrix");
  const ctx = canvas.getContext("2d");
  let columns, drops;

  function resizeCanvas() {
    // 画面サイズに合わせる
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    // 列数を再計算
    columns = Math.floor(canvas.width / 20);
    drops = Array(columns).fill(0); // 再定義することで描画のズレを防ぐ
  }

  window.addEventListener("resize", resizeCanvas);
  resizeCanvas(); // 初回実行

  function drawMatrixEffect() {
    ctx.fillStyle = "rgba(0, 0, 0, 0.1)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#00ff00";
    ctx.font = "16px monospace";

    for (let i = 0; i < columns; i++) {
      const char = Math.floor(Math.random() * 10).toString();
      const x = i * 20;
      const y = drops[i] * 20;
      ctx.fillText(char, x, y);

      // 画面サイズ変更に対応させるための修正
      if (y > canvas.height && Math.random() > 0.975) {
        drops[i] = 0;
      } else {
        drops[i]++;
      }
    }
  }

  setInterval(drawMatrixEffect, 33);
  </script>
</body>
</html>