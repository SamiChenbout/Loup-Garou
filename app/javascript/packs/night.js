const cupidon = () => {
  if(document.querySelector('.cupidon')) {
    randomCouple();
  }
}

const sorciere = () => {
  if(document.querySelector('.sorciere')) {
    sorciere();
  }
}



// Accessing game id

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

const loup = () => {
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

export { cupidon };
export { sorciere };
