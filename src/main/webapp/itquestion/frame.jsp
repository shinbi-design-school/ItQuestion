<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ITクイズゲーム | フレーム</title>

  <script>
    let bgmAudio = null;
    let bgmStarted = false;

    function startBGMIfNeeded() {
      if (!bgmStarted) {
        bgmAudio = new Audio("/itquestion/sound/start.mp3");
        bgmAudio.loop = true;
        bgmAudio.volume = 0.5;
        bgmAudio.play().then(() => {
          console.log('✅ start.mp3 再生成功');
        }).catch(err => {
          console.log('⚠️ start.mp3 再生エラー:', err);
        });
        bgmStarted = true;
      }
    }

    function changeBGM(src) {
      if (bgmAudio) {
        bgmAudio.pause();
        bgmAudio.currentTime = 0;
        bgmAudio = null;
      }
      bgmAudio = new Audio(src);
      bgmAudio.loop = true;
      bgmAudio.volume = 0.5;
      bgmAudio.play().then(() => {
        console.log(`✅ ${src} に切り替え成功`);
      }).catch(err => {
        console.log(`⚠️ ${src} 切り替え失敗:`, err);
      });
      bgmStarted = true;
    }
  </script>

</head>

<frameset rows="0,*" frameborder="no" border="0" framespacing="0">
  <frame src="/itquestion/itquestion/top.jsp" name="topFrame" noresize scrolling="no" style="display:none;">
  <frame src="/itquestion/itquestion/top.jsp" name="mainFrame" noresize scrolling="auto">
</frameset>

<noframes>
  <body>
    <p>このページはフレーム対応ブラウザ用です。</p>
  </body>
</noframes>

</html>







