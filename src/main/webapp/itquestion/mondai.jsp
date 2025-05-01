<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Question" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>クイズ | アイティークイズゲーム</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      font-family: 'Share Tech Mono', monospace;
      background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
      color: #00f0ff;
      height: 100%;
      overflow: hidden;
    }

    .matrix-bg {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 0;
    }

    .matrix-line {
      position: absolute;
      width: 2px;
      height: 100%;
      background: rgba(0, 255, 0, 0.1);
      animation: fall 3s linear infinite;
    }

    @keyframes fall {
      0% { transform: translateY(-100%); }
      100% { transform: translateY(100%); }
    }

    .container {
      position: relative;
      z-index: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      padding: 20px;
      box-sizing: border-box;
      text-align: center;
      overflow: hidden;
    }

    .question-box {
      background-color: rgba(0, 0, 0, 0.85);
      padding: 50px;
      border-radius: 12px;
      box-shadow: 0 0 30px #00f0ff;
      margin-bottom: 40px;
      width: 100%;
      max-width: 1100px;
    }

    .question {
      font-size: 36px;
      font-weight: bold;
      color: orange;
      padding: 20px;
      border-radius: 10px;
      text-shadow: 0 0 10px #ffcc66;
    }

    .options {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 30px;
      max-width: 800px;
      width: 100%;
    }

    .btn-option {
      width: 100%;
      padding: 30px 20px;
      font-size: 24px;
      font-weight: bold;
      background-color: #00f0ff;
      color: #0f0f0f;
      border: none;
      border-radius: 14px;
      cursor: pointer;
      transition: all 0.3s ease;
      box-shadow: 0 0 25px #00f0ff;
    }

    .btn-option:hover {
      background-color: #00d5e2;
      box-shadow: 0 0 35px #00eaff;
    }

    .hint {
      margin-top: 30px;
      font-size: 20px;
      color: #ffcc00;
      background-color: rgba(0, 0, 0, 0.6);
      padding: 15px 25px;
      border-radius: 10px;
      box-shadow: 0 0 15px #ffaa00;
      min-height: 60px;
      visibility: hidden;
      opacity: 0;
      transition: opacity 0.5s ease;
    }

    .hint.show {
      visibility: visible;
      opacity: 1;
    }

    .footer {
      margin-top: 30px;
      font-size: 14px;
      opacity: 0.7;
    }

    .timer {
      position: fixed;
      top: 20px;
      right: 30px;
      font-size: 24px;
      font-weight: bold;
      color: #00f0ff;
      background: rgba(0, 0, 0, 0.6);
      padding: 10px 20px;
      border-radius: 8px;
      box-shadow: 0 0 15px #00f0ff;
      z-index: 10;
    }

    .home-icon {
      position: fixed;
      bottom: 20px;
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
      z-index: 3;
      border-radius: 0px;
    }

    .home-icon svg {
      fill: #000;
      transition: transform 0.3s ease;
    }

    .home-icon:hover {
      background: linear-gradient(145deg, #00d5e2, #007b8a);
      box-shadow: 0 0 30px #00eaff, 0 0 60px #00eaff;
    }

    .home-icon:hover svg {
      transform: scale(1.2);
    }

    @media (max-width: 768px) {
      .options {
        grid-template-columns: 1fr;
      }

      .btn-option {
        font-size: 20px;
        padding: 20px;
      }

      .question {
        font-size: 28px;
      }
    }
  </style>
</head>
<body>
<%
    List<Question> questionList = (List<Question>)request.getAttribute("questionList");
%>
<script>
window.addEventListener("load", () => {
	  setTimeout(() => {
	    if (parent && typeof parent.changeBGM === "function") {
	      parent.changeBGM("/itquestion/sound/mondai.mp3");
	    }
	  }, 300); // 遅延があることで再生ブロック回避しやすい
	});

 
</script>


<script>
  const questions = [
    <% 
      if (questionList != null) {
          for (int i = 0; i < questionList.size(); i++) {
              Question q = questionList.get(i);
    %>
    {
      questionId: <%= q.getQuestion_Id() %>,
      question: "<%= q.getQuestion().replace("\"", "\\\"") %>",
      options: [
        "<%= q.getOption1().replace("\"", "\\\"") %>",
        "<%= q.getOption2().replace("\"", "\\\"") %>",
        "<%= q.getOption3().replace("\"", "\\\"") %>",
        "<%= q.getOption4().replace("\"", "\\\"") %>"
      ],
      correctOption: <%= q.getCorrectOption() %>,
      hint: "<%= q.getHint().replace("\"", "\\\"") %>"
    }<%= (i < questionList.size() - 1) ? "," : "" %>
    <% 
          }
      }
    %>
  ];
</script>

<div class="matrix-bg">
  <div class="matrix-line" style="left: 5%; animation-delay: 0s;"></div>
  <div class="matrix-line" style="left: 25%; animation-delay: 0.6s;"></div>
  <div class="matrix-line" style="left: 50%; animation-delay: 1.2s;"></div>
  <div class="matrix-line" style="left: 75%; animation-delay: 1.8s;"></div>
  <div class="matrix-line" style="left: 95%; animation-delay: 2.4s;"></div>
</div>

<div class="timer" id="timer">60秒</div>

<div class="container">
  <div class="question-box">
    <div class="question">ここに問題が表示されます</div>
  </div>

  <div class="options">
    <button class="btn-option">1. 選択肢1</button>
    <button class="btn-option">2. 選択肢2</button>
    <button class="btn-option">3. 選択肢3</button>
    <button class="btn-option">4. 選択肢4</button>
  </div>

  <div class="hint" id="hint">💡 ヒント欄</div>
  <div class="footer">© 2025 IT Quiz Project</div>
</div>

<a href="top.jsp" class="home-icon" title="トップへ戻る">
  <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24">
    <path d="M12 3l9 8h-3v10h-4v-6H10v6H6V11H3l9-8z"/>
  </svg>
</a>


<script>
  window.onload = function () {
    console.log("window.onloadスタート");
    console.log("questions配列の中身（受け取った全問題）:", questions);

    let timeLeft = 60;
    const timerDisplay = document.getElementById("timer");
    const hint = document.getElementById("hint");

    displayQuestion(currentIndex);

    const countdown = setInterval(() => {
      timeLeft--;
      timerDisplay.textContent = timeLeft + '秒';

      if (timeLeft === 30) {
        hint.classList.add("show");
      }

      if (timeLeft <= 0) {
        clearInterval(countdown);
        timerDisplay.textContent = "時間切れ！";
      }
    }, 1000);
  };

  let currentIndex = 0;
  let timeLeft = 60;
  let countdown; // タイマーのインターバルID

  window.onload = function () {
    console.log("window.onloadスタート");
    displayQuestion(currentIndex); // 最初の1問目を表示
  };

  function displayQuestion(index) {
    clearInterval(countdown);        // ★ 前のタイマーを止める
    timeLeft = 60;                   // ★ タイマーをリセット

    const question = questions[index];
    console.log("表示する問題:", question);

    document.querySelector('.question').textContent = question.question;

    const optionButtons = document.querySelectorAll('.btn-option');
    optionButtons.forEach((btn, i) => {
      btn.textContent = (i + 1) + '. ' + question.options[i];
      btn.setAttribute(
        'onclick',
        'nextQuestion(' + ((i + 1) === question.correctOption) + ', ' + (i + 1) + ')'
      );
    });


    const hint = document.getElementById('hint');
    hint.classList.remove("show");
    hint.textContent = '💡 ヒント: ' + question.hint;

    const timerDisplay = document.getElementById("timer");
    timerDisplay.textContent = timeLeft + '秒';

    // ★ 新しいタイマー開始
    countdown = setInterval(() => {
      timeLeft--;
      timerDisplay.textContent = timeLeft + '秒';

      if (timeLeft === 30) {
        hint.classList.add("show");
      }

      if (timeLeft <= 0) {
        clearInterval(countdown);
        timerDisplay.textContent = "時間切れ！";
        nextQuestion(false); // 時間切れ＝不正解として次へ
      }
    }, 1000);
  }

  function nextQuestion(isCorrect, selectedOptionIndex = -1) {
	  const currentQuestion = questions[currentIndex];

	  // ★ Ajaxでサーバーへ回答を送信
	  const xhr = new XMLHttpRequest();
	  xhr.open("POST", "SaveAnswer.action", true);
	  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	  const postData =
	    "question_id=" + currentQuestion.questionId +
	    "&selected_option=" + selectedOptionIndex +
	    "&is_correct=" + (isCorrect ? 1 : 0);

	  xhr.send(postData); // ← useranswer に1問ずつ保存される！

	  // 次の問題へ
	  currentIndex++;
	  if (currentIndex < questions.length) {
	    displayQuestion(currentIndex);
	  } else {
	    window.location.href = "Result.action"; // ← クイズ完了後の画面（後ほど作る）
	  }
	}


</script>

</body>
</html>