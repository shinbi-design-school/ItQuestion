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