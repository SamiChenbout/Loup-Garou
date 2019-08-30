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

const myTimer = (timeLeft, whatFetch) => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  const timerDiv = document.getElementById("countdown");
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

export { cupidon, voyante, chasseur, loup, sorciere };
