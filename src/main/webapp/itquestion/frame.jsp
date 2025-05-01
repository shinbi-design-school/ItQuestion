<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Question" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ITクイズゲーム | フレーム</title>

  
<script>
let bgmAudio = new Audio("/itquestion/sound/start.mp3");
bgmAudio.loop = true;
bgmAudio.volume = 0.5;
let bgmStarted = false;

function startBGMIfNeeded() {
  if (!bgmStarted) {
    bgmAudio.play().then(() => {
      console.log('親frame.jspでBGM再生成功');
    }).catch((err) => {
      console.log('親frame.jspでBGM再生エラー:', err);
    });
    bgmStarted = true;
  }
}
//← これを追加（再生中のBGMを変更する）
function changeBGM(src) {
  if (bgmAudio) {
    bgmAudio.pause();
  }
  bgmAudio = new Audio(src);
  bgmAudio.loop = true;
  bgmAudio.volume = 0.5;
  bgmAudio.play().catch(err => console.log("BGM切り替え失敗:", err));
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






