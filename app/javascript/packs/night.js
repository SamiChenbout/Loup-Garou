const cupidon = () => {
  if(document.querySelector('.cupidon')) {
    myTimer(15, randomCoupleChoose());
  }
}

const voyante = () => {
  if(document.querySelector('.voyante')) {
    myTimer(15, randomVoyanteChoose());
  }
}

const loup = () => {
  if(document.querySelector('.loups')) {
    myTimer(30, randomLoupChoose());
  }
}

const sorciere = () => {
  if(document.querySelector('.sorciere')) {
    myTimer(15, randomSorciereChoose());
  }
}

const chasseur = () => {
  if(document.querySelector('.chasseur')) {
    myTimer(10, randomChasseurChoose());
  }
}

// Default action calls if no action taken by user
const randomCoupleChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  fetch(`/games/${gameId}/random_couple_choose`);
}

const andomVoyanteChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  fetch(`/games/${gameId}/voyante_next_step`);
}

const randomLoupChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  fetch(`/games/${gameId}/random_loup_choose`);
}

const randomSorciereChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  fetch(`/games/${gameId}/random_sorciere_choose`);
}

const randomChasseurChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  fetch(`/games/${game_id}/random_chasseur_kill`);
}

const myTimer = (timeLeft, myfonc) => {
  const timerDiv = document.getElementById("countdown");
  setInterval(function(){
    if (timerDiv)
      timerDiv.innerHTML = timeLeft;
      timeLeft -= 1;
      if(timeLeft <= 0){
        clearInterval(timer);
        myfonc();
      }
  }, 1000);
}

export { cupidon, voyante, chasseur, loup, sorciere };
