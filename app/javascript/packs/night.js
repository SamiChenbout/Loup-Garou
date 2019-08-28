// Accessing game id
const cupidon = () => {
  if(document.querySelector('.cupidon')) {
    randomCouple();
  }
}

const loup = () => {
  if(document.querySelector('.loup')) {
    randomLoupVote();
  }
}

const voyante = () => {
  if(document.querySelector('.voyante')) {
    randomCouple();
  }
}

const chasseur = () => {
  if(document.querySelector('.chasseur')) {
    randomCouple();
  }
}

// Default action calls if no action taken by user
const randomCouple = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/random_couple`);
  }, 3000);
}

const voyante = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/voyante_next_step`);
  }, 3000);
}

const randomLoupVote = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${gameId}/random_loup_vote`);
  }, 3000);
}

const sorciere = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    console.log("rien");
    fetch(`/games/${gameId}/random_sorciere_vote`);
  }, 3000);
}

const chasseur = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  const gameId = gameDiv.dataset.gameId;
  setTimeout(function() {
    fetch(`/games/${game_id}/chasseur_random_kill`);
  }, 3000);
}

export { cupidon, voyante, chasseur };
