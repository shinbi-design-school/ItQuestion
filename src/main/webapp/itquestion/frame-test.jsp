<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>音楽テスト</title>
  <script>
    window.addEventListener('DOMContentLoaded', () => {
      const audio = new Audio("/itquestion/sound/start.mp3");
      audio.loop = true;
      audio.volume = 0.5;
      audio.play().catch(err => {
        console.error("BGM再生エラー", err);
      });
    });
  </script>
</head>
<body>
  <h1>BGMテストページ</h1>
  <p>このページを開いたらBGMが鳴るかチェック！</p>
</body>
</html>


