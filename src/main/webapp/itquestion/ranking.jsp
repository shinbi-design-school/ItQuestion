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

  h1, table, .btn {
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
  table-layout: fixed; /* 列幅を均等に固定 */
}

th, td {
  width: 33.33%; /* 全列を同じ幅に */
  padding: 12px;
  text-align: center;
  border-bottom: 1px solid #00f0ff;
  word-wrap: break-word; /* 長い語を折り返す */
  font-size: 25px; /* ← ここを追加してサイズアップ（デフォルト16pxから少し大きめ） */
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

  /* ==== 右下アイコン群（ホーム＆Fin） ==== */
  .icon-container {
    position: fixed;
    bottom: 20px;
    right: 20px;
    display: flex;
    flex-direction: column;
    gap: 12px;
    z-index: 10;
  }

  .icon-link {
    width: 56px;
    height: 56px;
    background: linear-gradient(145deg, #00f0ff, #005a66);
    box-shadow: 0 0 20px #00f0ff, 0 0 40px #00f0ff;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    transition: all 0.3s ease;
    border-radius: 0px;
    overflow: hidden;
  }

  .icon-link svg {
    width: 36px;
    height: 36px;
    transition: transform 0.3s ease;
  }

  .icon-link:hover {
    background: linear-gradient(145deg, #00d5e2, #007b8a);
    box-shadow: 0 0 30px #00eaff, 0 0 60px #00eaff;
  }

  .icon-link:hover svg,
  .icon-link:hover img {
    transform: scale(1.1);
  }

  .home-icon svg {
    fill: #000;
  }

  .fin-icon img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
  }
  
 /* 1位、2位、3位の行 */
.rank-1 {
  color: #FFFF00; /* 明るい黄色 */
  text-shadow: 0 0 6px #00ff00, 0 0 12px #00ff00;
}

.rank-2 {
  color: #00FFFF; /* 明るいシアン */
  text-shadow: 0 0 6px #00eaff, 0 0 12px #00eaff;
}

.rank-3 {
  color: #E6E6FA; /* ラベンダー */
  text-shadow: 0 0 6px #a020f0, 0 0 12px #a020f0;
}

/* その他の行のホバー時の強調背景 */
tr:hover {
  background-color: rgba(0, 255, 255, 0.2); /* ホバー時の強調背景 */
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
  <tr class="${rank == 1 ? 'rank-1' : (rank == 2 ? 'rank-2' : (rank == 3 ? 'rank-3' : ''))}">
    <td>${rank}</td> <!-- リストの順番で順位を設定 -->
    <td>${user.username}</td> <!-- username を表示 -->
    <td>${user.score}</td> <!-- score を表示 -->
  </tr>
</c:forEach>


        
      <!-- 
      <c:set var="rank" value="0" /> <!-- 順位カウント用変数
        <c:forEach var="user" items="${rankingList}">
          <c:set var="rank" value="${rank + 1}" /> <!-- 順位をインクリメント
          <tr>
            <td>${rank}</td> <!-- リストの順番で順位を設定
            <td>${user.username}</td> <!-- username を表示
            <td>${user.score}</td> <!-- score を表示
          </tr>
        </c:forEach>
        -->
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="3">ランキング情報がありません。</td>
        </tr>
      </c:otherwise>
    </c:choose>
  </table>
	
 	<div class="icon-container">
  <!-- ホームへ -->
  <a href="top.jsp" class="icon-link home-icon" title="トップへ戻る">
    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24">
      <path d="M12 3l9 8h-3v10h-4v-6H10v6H6V11H3l9-8z"/>
    </svg>
  </a>

  <!-- Fin（エンディングへ） -->
  <a href="javascript:void(0);" class="icon-link fin-icon" onclick="parent.mainFrame.location.href='ending.jsp'" title="エンディングへ">
    <img src="../image/fin2.png" alt="Fin" />
  </a>
</div>



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
  <script src="/itquestion/js/sound.js"></script>
    <script>
      setupSounds("/itquestion/sound/cursor.mp3", "/itquestion/sound/click.mp3");
    </script>
</body>
</html>