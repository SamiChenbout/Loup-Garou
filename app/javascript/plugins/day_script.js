const dayScript = () => {
  myTimerDay(120, document.querySelector('.day'), `when_night_comes`);
  myTimerDay(1, document.querySelector('.end-day-calcul'), `when_night_talk`);
  myTimerDay(10, document.querySelector('.end-day'), `night`);
  myTimerDay(10, document.querySelector('.show-role'), `night`);
}

const myTimerDay = (timeLeft, ifDivIs, whatFetch) => {
  if(ifDivIs) {
    const gameDiv = document.getElementById("connect-to-game-channel");
    const gameId = gameDiv.dataset.gameId;
    const timerDiv = document.getElementById("countdown");
    var timer = setInterval(function(){
    if (timerDiv)
      timerDiv.innerHTML = timeLeft;
      timeLeft -= 1;
      if(timeLeft <= 0){
        clearInterval(timer);
        window.location = `/games/${gameId}/${whatFetch}`;
      }
  }, 1000);
  }
}

export { dayScript }
