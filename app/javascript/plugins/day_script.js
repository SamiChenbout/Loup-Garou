const dayScript = () => {
  myTimer(180, document.querySelector('.day'), `/games/${gameId}/end-day-calcul`);
  myTimer(0, document.querySelector('.end-day-calcul'), `/games/${gameId}/end-day`);
  myTimer(5, document.querySelector('.end-day'), `/games/${gameId}/end-day`);
}

const myTimer = (timeLeft, ifDivIs, whatFetch) => {
  const timerDiv = document.getElementById("countdown");
  if(ifDivIs) {
    setInterval(function(){
    if (timerDiv)
      timerDiv.innerHTML = timeLeft;
      timeLeft -= 1;
      if(timeLeft <= 0){
        clearInterval(timer);
        fetch(whatFetch);
      }
  }, 1000);
  }
}

export { dayScript }
