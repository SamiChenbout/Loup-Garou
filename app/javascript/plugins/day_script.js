const dayScript = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  myTimerDay(180, document.querySelector('.day'), `end-day-calcul`);
  myTimerDay(0, document.querySelector('.end-day-calcul'), `end-day`);
  myTimerDay(5, document.querySelector('.end-day'), `end-day`);
}

const myTimerDay = (timeLeft, ifDivIs, whatFetch) => {
  const timerDiv = document.getElementById("countdown");
  if(ifDivIs) {
    var timer = setInterval(function(){
    if (timerDiv)
      timerDiv.innerHTML = timeLeft;
      timeLeft -= 1;
      if(timeLeft <= 0){
        clearInterval(timer);
        fetch(`/games/${gameId}/${whatFetch}`);
      }
  }, 1000);
  }
}

export { dayScript }
