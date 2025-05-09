<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Ending | Special Thanks</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      background: black;
      color: #00ff00;
      font-family: 'Share Tech Mono', monospace;
      height: 100vh;
      overflow-y: auto;
      position: relative;
    }
    canvas {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
    }
    .mask-layer {
      position: fixed;
      top: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 90%;
      max-width: 600px;
      height: 100vh;
      background-color: black;
      z-index: 1;
    }
    .box {
      position: relative;
      z-index: 2;
      padding-top: 20px;
      width: 90%;
      max-width: 600px;
      margin: 50px auto 0 auto;
      text-align: center;
    }
    .typing-line {
      display: block;
      font-size: 4vw;
      margin: 8px 0;
      text-shadow: 0 0 10px #00ff00;
      min-height: 1.5em;
    }
    .members-line {
      font-size: 6vw;
      font-weight: bold;
    }
    .member-line {
      display: flex;
      justify-content: space-between;
      font-size: 4vw;
      margin: 6px 0;
      text-shadow: 0 0 10px #00ff00;
    }
    .role, .name {
      width: 45%;
    }
    .role {
      text-align: right;
    }
    .name {
      text-align: left;
    }
    .to-top {
      background: transparent;
      border: 2px solid #00ff00;
      color: #00ff00;
      font-family: 'Share Tech Mono', monospace;
      font-size: 16px;
      padding: 8px 16px;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.3s, color 0.3s, transform 0.3s;
      margin-top: 30px;
    }
    .to-top:hover {
      background: #00ff00;
      color: black;
      transform: scale(1.05);
      box-shadow: 0 0 12px #00ff00;
    }
    @media (min-width: 768px) {
      .typing-line, .member-line {
        font-size: 24px;
      }
      .members-line {
        font-size: 32px;
      }
    }
  </style>
</head>
<body>
<script>
window.addEventListener("load", () => {
  setTimeout(() => {
    if (parent && typeof parent.changeBGM === "function") {
      parent.changeBGM("/itquestion/sound/ending.mp3");
      console.log("🎵 ending.jspでBGMをending.mp3に切り替えました");
    }
  }, 300);
});
</script>

<canvas id="matrix"></canvas>
<div class="mask-layer"></div>
<div class="box" id="typing-box"></div>

<script>
  const lines = [
    "Special Thanks",
    "Team : Middle & Young",
    "Members",
    { role: "Leader", name: "H.I" },
    { role: "Sub Leader", name: "T.A" },
    { role: "Frontend", name: "T.W" },
    { role: "Backend", name: "R.M" },
    "Advisers",
    "Mr. Tanaka    Ms. Usui",
    "Ms. Akabane  Mr. Takita",
    "Thank you for playing!"
  ];

  const box = document.getElementById("typing-box");
  let lineIndex = 0;
  let charIndex = 0;
  let currentLine = null;

  let isSpeedUp = false;
  window.addEventListener("mousedown", () => isSpeedUp = true);
  window.addEventListener("mouseup", () => isSpeedUp = false);
  window.addEventListener("touchstart", () => isSpeedUp = true);
  window.addEventListener("touchend", () => isSpeedUp = false);

  const getTypingSpeed = () => isSpeedUp ? 10 : 50;

  function type() {
    if (lineIndex >= lines.length) {
      addToTopButton();
      return;
    }

    const line = lines[lineIndex];

    if (typeof line === "object") {
      const container = document.createElement("div");
      container.className = "member-line";

      const role = document.createElement("div");
      role.className = "role";
      role.textContent = "";

      const name = document.createElement("div");
      name.className = "name";
      name.textContent = "";

      container.appendChild(role);
      container.appendChild(name);
      box.appendChild(container);

      let r = 0, n = 0;
      function typeRoleAndName() {
        if (r < line.role.length) {
          role.textContent += line.role.charAt(r++);
          setTimeout(typeRoleAndName, getTypingSpeed());
        } else if (n < line.name.length) {
          name.textContent += line.name.charAt(n++);
          setTimeout(typeRoleAndName, getTypingSpeed());
        } else {
          lineIndex++;
          setTimeout(type, 300);
        }
      }
      typeRoleAndName();
    } else {
      if (charIndex === 0) {
        currentLine = document.createElement("div");
        currentLine.className = "typing-line";

        if (
          line === "Members" ||
          line === "Special Thanks" ||
          line === "Advisers" ||
          line === "Thank you for playing!"
        ) {
          currentLine.classList.add("members-line");
        }

        box.appendChild(currentLine);
      }

      if (charIndex < line.length) {
        currentLine.textContent += line.charAt(charIndex++);
        setTimeout(type, getTypingSpeed());
      } else {
        charIndex = 0;
        lineIndex++;
        setTimeout(type, 300);
      }
    }
  }

  function addToTopButton() {
    const div = document.createElement("div");
    div.style.textAlign = "center";
    const btn = document.createElement("button");
    btn.className = "to-top";
    btn.textContent = "To Top";
    btn.onclick = () => {
      const clickSound = new Audio("/itquestion/sound/click.mp3");
      clickSound.play().catch(e => console.error("クリック音エラー:", e));
      setTimeout(() => {
        parent.mainFrame.location.href = 'Remove.action';
      }, 300);
    };
    div.appendChild(btn);
    box.appendChild(div);
  }

  type();

  const canvas = document.getElementById("matrix");
  const ctx = canvas.getContext("2d");
  let columns, drops;

  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    columns = Math.floor(canvas.width / 20);
    drops = Array(columns).fill(0);
  }

  window.addEventListener("resize", resizeCanvas);
  resizeCanvas();

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
