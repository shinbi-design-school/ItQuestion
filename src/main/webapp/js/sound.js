

const clickSound = new Audio("/itquestion/sound/click.mp3");


function playClickSound() {
  clickSound.currentTime = 0;
  clickSound.play();
}


window.addEventListener('DOMContentLoaded', () => {
  
  const clickableElements = document.querySelectorAll('button, a, input[type="submit"], input[type="button"]');

  clickableElements.forEach(elem => {
    elem.addEventListener('click', () => {
      playClickSound();
    });
  });
});
