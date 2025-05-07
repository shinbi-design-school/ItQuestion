<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>結果発表 | アイティークイズゲーム</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">

<style>
    
    body {
	  font-family: 'Share Tech Mono', monospace;
	  background: #000;
	  color: #00f0ff;
	  margin: 0;
	  padding: 0;
	  overflow: auto; 
	}
	
	.result-box {
	  position: relative; 
	  margin: 30px auto; /* 自然な余白を追加 */
	  max-width: 90%; /* コンテンツの幅を適切に制限 */
	  background-color: rgba(0, 0, 0, 0.8);
	  padding: 20px;
	  border-radius: 12px;
	  box-shadow: 0 0 20px #00f0ff;
	  text-align: center;
	}
    
canvas {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
}
    .result-title {
      font-size: 36px;
      margin-bottom: 10px;
      text-shadow: 0 0 10px #00f0ff;
    }
/*
    .user-name {
      font-size: 24px;
      margin-bottom: 20px;
    }
*/
    .score-info {
      position: absolute;
      top: 80px;
      left: 50px; 
      font-size: 24px;
      font-weight: bold;
      color: #00ffff;
      text-shadow: 0 0 50px #00f0ff, 0 0 20px #00f0ff;
      text-align: left;
    }

    .score-point {
      font-size: 42px;
      margin-left: 30px;
      color: #FFA500;
    }

    .question-table {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed;
      margin-top: 40px;
    }

    .question-table th, .question-table td {
      border: 1px solid #00f0ff;
      padding: 10px;
      text-align: center;
      font-size: 16px;
      word-wrap: break-word;
    }

    .question-table th {
      background-color: rgba(0, 240, 255, 0.2);
    }

    .col-problem { width: 35%; }
    .col-correct { width: 25px; }
    .col-answer { width: 20%; }
    .col-explanation { width: 45%; }

    .correct-mark { color: #00ffff; font-size: 24px; }
    .wrong-mark { color: #ff69b4; font-size: 24px; }

    .icon-link {
      position: fixed;
      right: 20px;
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
      z-index: 5;
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

    .icon-link:hover svg {
      transform: scale(1.2);
    }

    .home-icon { top: 20px; }
    .ranking-icon { top: 90px; }
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

<div class="result-box">
  <div class="result-title"><p>結果発表</p>
  <!-- <div class="user-name"><strong>${username}</strong></div> -->
  <div class="score-info">${username} さんのスコアは<span class="score-point">${sessionScope.score}</span>点</div>
</div>

  <table class="question-table">
    <thead>
      <tr>
        <th class="col-problem">問題</th>
        <th class="col-correct">正誤</th>
        <th class="col-answer">正解</th>
        <th class="col-explanation">解説</th>
      </tr>
    </thead>
    <tbody>
    <c:set var="questionList" value="${sessionScope.resultList}" />
    <c:if test="${empty questionList}">
      <tr>
        <td colspan="4">データがありません。</td>
      </tr>
    </c:if>


<c:forEach var="item" items="${questionList}" varStatus="status">
  <tr>
    <td><c:out value="${item.question.question}" /></td>
    <td>
      <c:choose>
        <c:when test="${item.is_correct eq true}">
          <span class="correct-mark">〇</span>
        </c:when>
        <c:otherwise>
          <span class="wrong-mark">×</span>
        </c:otherwise>
      </c:choose>
    </td>
      <td><c:out value="${item.correctOptionText}" /></td>
      <td><c:out value="${item.question.description}" /></td>
 <!-- 
    <td>
      <button class="toggle-btn" onclick="toggleExplanation(${status.index})" id="btn-${status.index}">解説 ＋</button>
    </td>
  </tr>
  <tr class="explanation-row" id="explanation-${status.index}">
    <td colspan="4" class="explanation-cell">
      <c:if test="${empty item.question.description}">
        説明なし
      </c:if>
      <c:if test="${not empty item.question.description}">
        ${item.question.description}
      </c:if>
    </td>
  </tr>
  -->
  
</c:forEach>

    </tbody>
  </table>
</div>

<a href="Ranking.action" class="icon-link ranking-icon" title="ランキングへ">
  <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" width="36" height="36">
    <defs>
      <linearGradient id="goldGradient" x1="0%" y1="0%" x2="100%" y2="0%">
        <stop offset="0%" style="stop-color:#FFD700; stop-opacity:1" />
        <stop offset="100%" style="stop-color:#FFA500; stop-opacity:1" />
      </linearGradient>
    </defs>
    <path fill="url(#goldGradient)" d="M5 8l3 3 4-8 4 8 3-3 5 9H0l5-9zm0 11h14v2H5v-2z"/>
  </svg>
</a>



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

/*
  function toggleExplanation(index) {
    const explanation = document.getElementById(`explanation-${index}`);
    const button = document.getElementById(`btn-${index}`);
    if (explanation.style.display === "none" || explanation.style.display === "") {
      explanation.style.display = "table-row";
      button.innerText = "解説 −";
    } else {
      explanation.style.display = "none";
      button.innerText = "解説 ＋";
    }
  }
*/
</script>

</body>
</html>