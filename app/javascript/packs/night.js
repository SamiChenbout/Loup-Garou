const cupidon = () => {
  if(document.querySelector('.cupidon')) {
    myTimer(15, `random_couple_choose`);
  }
}

const voyante = () => {
  if(document.querySelector('.voyante')) {
    myTimer(15, `voyante_next_step`);
  }
}

const loup = () => {
  if(document.querySelector('.loup')) {
    myTimer(30, `random_loup_choose`);
  }
}

const sorciere = () => {
  if(document.querySelector('.sorciere')) {
    myTimer(15, `random_sorciere_choose`);
  }
}

const chasseur = () => {
  if(document.querySelector('.chasseur')) {
    myTimer(10, `random_chasseur_kill`);
  }
}

const night = () => {
  if(document.querySelector('.nuit-interlude')) {
    const gameDiv = document.getElementById("connect-to-game-channel");
    const gameId = gameDiv.dataset.gameId;
    const timerDiv = document.getElementById("countdown");
    let timerLeft = 10;
    var timer = setInterval(function(){
      if (timerLeft) {
        timerDiv.innerHTML = timerLeft;
        timerLeft -= 1;
        if(timerLeft <= 0){
          clearInterval(timer);
          if(gameDiv.dataset.round === "1") {
            window.location = `/games/${gameId}/cupidon`;
          } else if(gameDiv.dataset.voyante === "true") {
            window.location = `/games/${gameId}/voyante`;
          } else {
            window.location = `/games/${gameId}/loup`;
          }
        }
      }
    }, 1000);
  }
}

const day = () => {
  if(document.querySelector('.day-interlude')) {
    const gameDiv = document.getElementById("connect-to-game-channel");
    const gameId = gameDiv.dataset.gameId;
    const timerDiv = document.getElementById("countdown");
    let timerLeft = 10;
    var timer = setInterval(function(){
      if (timerLeft) {
        timerDiv.innerHTML = timerLeft;
        timerLeft -= 1;
        if(timerLeft <= 0){
          clearInterval(timer);
          window.location = `/games/${gameId}/when_day_comes`;
        }
      }
    }, 1000);
  }
}

const myTimer = (timeLeft, whatFetch) => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  const timerDiv = document.getElementById("countdown");
  var timer = setInterval(function(){
    if (timerDiv) {
      timerDiv.innerHTML = timeLeft;
      timeLeft -= 1;
      if(timeLeft <= 0){
        clearInterval(timer);
        fetch(`/games/${gameId}/${whatFetch}`);
      }
    }
  }, 1000);
}

export { cupidon, voyante, chasseur, loup, sorciere, night, day };
