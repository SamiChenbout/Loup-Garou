const firstNight = () => {
  if(document.querySelector('.firstNight')) {
    // Cupidon First
    document.querySelector('.cupidon').classList.remove('d-none');
    randomCouple();
    // Voyante
    setTimeout(function() {
      document.querySelector('.cupidon').classList.add('d-none');
      document.querySelector('.voyante').classList.remove('d-none');
      voyante();
    }, 3000)
    // // loup
    setTimeout(function() {
      document.querySelector('.voyante').classList.add('d-none');
      document.querySelector('.loup').classList.remove('d-none');
      loup();
    }, 6000)
    // // sorciere
    setTimeout(function() {
      document.querySelector('.loup').classList.add('d-none');
      document.querySelector('.sorciere').classList.remove('d-none');
      sorciere();
    }, 9000)
    // // le jour se leve !
    // document.querySelector('.sorciere').classList.add('d-none');
  };
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

export { firstNight };
