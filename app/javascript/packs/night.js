const cupidon = () => {
  if(document.querySelector('.cupidon')) {
    randomCoupleChoose();
  }
}

const voyante = () => {
  if(document.querySelector('.voyante')) {
    randomVoyanteChoose();
  }
}

const loup = () => {
  if(document.querySelector('.loups')) {
    randomLoupChoose();
  }
}

const sorciere = () => {
  if(document.querySelector('.sorciere')) {
    randomSorciereChoose();
  }
}

const chasseur = () => {
  if(document.querySelector('.chasseur')) {
    randomChasseurChoose();
  }
}

// Default action calls if no action taken by user
const randomCoupleChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/random_couple_choose`);
  }, 15000000);
}

const andomVoyanteChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/voyante_next_step`);
  }, 15000000);
}

const randomLoupChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/random_loup_choose`);
  }, 15000000);
}

const randomSorciereChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/random_sorciere_choose`);
  }, 15000000);
}

const randomChasseurChoose = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${game_id}/random_chasseur_kill`);
  }, 15000000);
}

export { cupidon, voyante, chasseur, loup, sorciere };
