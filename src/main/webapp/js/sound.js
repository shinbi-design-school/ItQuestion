function setupSounds(hoverSrc = null, clickSrc = null) {
  document.addEventListener("DOMContentLoaded", () => {
    // ホバーとクリック対象を拡張
    const elements = document.querySelectorAll(
      'button, a, input[type="submit"], input[type="button"], .clickable, .home-icon, .ending-icon'
    );

    elements.forEach(el => {
      if (hoverSrc) {
        el.addEventListener("mouseenter", () => {
          const hoverSound = new Audio(hoverSrc);
          hoverSound.play().catch(e => console.error("ホバー音エラー:", e));
        });
      }

      if (clickSrc) {
        el.addEventListener("click", () => {
          const clickSound = new Audio(clickSrc);
          clickSound.play().catch(e => console.error("クリック音エラー:", e));
        });
      }
    });
  });
}
