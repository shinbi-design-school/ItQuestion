<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
      z-index: 0;
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
      margin: 0 auto;
      text-align: center;
    }
    .typing-line {
      display: block;
      font-size: 4vw;
      max-font-size: 24px;
      margin: 8px 0;
      text-shadow: 0 0 10px #00ff00;
      min-height: 1.5em;
    }
    .special-line {
      margin-top: 0;
      margin-bottom: 16px;
    }
    .member-line {
      display: flex;
      justify-content: space-between;
      font-size: 4vw;
      max-font-size: 24px;
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
    }
  </style>
</head>
<body>
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
    "",
    "Thank you for playing!"
  ];

  const box = document.getElementById("typing-box");
  let lineIndex = 0;
  let charIndex = 0;
  let currentLine = null;
  const typingSpeed = 50;

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
          setTimeout(typeRoleAndName, typingSpeed);
        } else if (n < line.name.length) {
          name.textContent += line.name.charAt(n++);
          setTimeout(typeRoleAndName, typingSpeed);
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
        if (lineIndex === 0) {
          currentLine.classList.add("special-line");
        }
        box.appendChild(currentLine);
      }

      if (charIndex < line.length) {
        currentLine.textContent += line.charAt(charIndex++);
        setTimeout(type, typingSpeed);
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
    btn.onclick = () => location.href = 'top.html';
    div.appendChild(btn);
    box.appendChild(div);
  }

  type();

  const canvas = document.getElementById("matrix");
  const ctx = canvas.getContext("2d");
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  const columns = Math.floor(canvas.width / 20);
  const drops = Array(columns).fill(0);
  function draw() {
    ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#00ff00";
    ctx.font = "16px monospace";
    for (let i = 0; i < drops.length; i++) {
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
  setInterval(draw, 33);
</script>
</body>
</html>
