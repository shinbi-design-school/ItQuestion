<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>結果発表 | アイティークイズゲーム</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">

  <style>
    /* （CSSは元のままなので省略せずコピペOK） */
    /* 上のスタイル部分はあなたのコードと同じ内容を使ってください */
        body {
      font-family: 'Share Tech Mono', monospace;
      background: #000;
      color: #00f0ff;
      margin: 0;
      padding: 0;
      overflow: hidden;
      height: 100vh;
      position: relative;
    }

    canvas {
      position: fixed;
      top: 0;
      left: 0;
      z-index: 0;
    }

    .result-box {
      position: absolute;
      top: 30px;
      left: 30px;
      right: 100px;
      background-color: rgba(0, 0, 0, 0.8);
      padding: 20px 30px 140px;
      border-radius: 12px;
      box-shadow: 0 0 20px #00f0ff;
      height: calc(100vh - 60px);
      overflow-y: auto;
      z-index: 2;
      text-align: center;
    }

    .result-title {
      font-size: 36px;
      margin-bottom: 10px;
      text-shadow: 0 0 10px #00f0ff;
    }

    .user-name {
      font-size: 24px;
      margin-bottom: 20px;
    }

    /* スコアを左寄せに変更 */
    .score-info {
      position: absolute;
      top: 80px;
      left: 50px; /* 左に寄せる */
      font-size: 24px;
      font-weight: bold;
      color: #00ffff;
      text-shadow: 0 0 50px #00f0ff, 0 0 20px #00f0ff;
      text-align: left;
    }

    .score-point {
      font-size: 36px;
      margin-left: 5px;
      color: #FFA500; /* オレンジ色 */
    }

    .question-table {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed;
      margin-top: 20px;
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

    .col-problem { width: 45%; }
    .col-correct { width: 40px; }
    .col-answer { width: 30%; }
    .col-explanation { width: 90px; }

    .correct-mark { color: #00ffff; font-size: 24px; }
    .wrong-mark { color: #ff69b4; font-size: 24px; }

    .explanation-row {
      display: none;
      background-color: rgba(0, 0, 0, 0.6);
    }

    .explanation-cell {
      padding: 10px;
      text-align: left;
      border: 1px solid #00f0ff;
      border-top: none;
    }

    .toggle-btn {
      background: none;
      border: 1px solid #00f0ff;
      color: #00f0ff;
      padding: 2px 5px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 16px;
      transition: background 0.3s;
      white-space: nowrap;
    }

    .toggle-btn:hover {
      background: #00f0ff;
      color: #000;
    }

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

    .home-icon { bottom: 20px; }
    .ranking-icon { bottom: 90px; }
  </style>
</head>

<body>

<canvas id="matrix"></canvas>

<div class="result-box">
  <div class="result-title">結果発表</div>
  <div class="user-name"><strong>${userName}</strong></div>

  <div class="score-info">
    あなたのスコアは<span class="score-point">${score}点</span>
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
      <c:forEach var="item" items="${questionList}" varStatus="status">
        <tr>
          <td>${item.question}</td>
          <td>
            <c:choose>
              <c:when test="${item.correctFlag}">
                <span class="correct-mark">〇</span>
              </c:when>
              <c:otherwise>
                <span class="wrong-mark">×</span>
              </c:otherwise>
            </c:choose>
          </td>
          <td>${item.correct}</td>
          <td><button class="toggle-btn" onclick="toggleExplanation(${status.index})" id="btn-${status.index}">解説 ＋</button></td>
        </tr>
        <tr class="explanation-row" id="explanation-${status.index}">
          <td colspan="4" class="explanation-cell">${item.explanation}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<a href="ranking.jsp" class="icon-link ranking-icon" title="ランキングへ">ランキング</a>
<a href="top.jsp" class="icon-link home-icon" title="トップへ">トップへ</a>





<script>
  const canvas = document.getElementById("matrix");
  const ctx = canvas.getContext("2d");
  canvas.height = window.innerHeight;
  canvas.width = window.innerWidth;
  const columns = Math.floor(canvas.width / 20);
  const drops = new Array(columns).fill(0);

  function draw() {
    ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#00ff00";
    ctx.font = "16px monospace";
    for (let i = 0; i < drops.length; i++) {
      const text = "|";
      const x = i * 20;
      const y = drops[i] * 20;
      ctx.fillText(text, x, y);
      if (y > canvas.height && Math.random() > 0.975) {
        drops[i] = 0;
      } else {
        drops[i]++;
      }
    }
  }
  setInterval(draw, 33);

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
</script>

</body>
</html>