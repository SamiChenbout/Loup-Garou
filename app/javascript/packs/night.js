const firstNight = () => {
  if(document.querySelector('.firstNight')) {
    // Cupidon First
    document.querySelector('.cupidon').classList.remove('d-none');
    randomCouple();
    // Voyante
    document.querySelector('.cupidon').classList.add('d-none');
    document.querySelector('.voyante').classList.remove('d-none');
    voyante();
    // loup
    document.querySelector('.voyante').classList.add('d-none');
    document.querySelector('.loup').classList.remove('d-none');
    loup();
    // sorciere
    document.querySelector('.loup').classList.add('d-none');
    document.querySelector('.sorciere').classList.remove('d-none');
    sorciere();
    // le jour se leve !
    document.querySelector('.sorciere').classList.add('d-none');
  };
}


// Accessing game id
const gameDiv = document.getElementById("connect-to-game-channel");
if (gameDiv) {
  const gameId = gameDiv.dataset.gameId;
}

// Default action calls if no action taken by user
const randomCouple = () => {
  setTimeout(function() {
    fetch(`/games/${gameId}/random_couple`);
  }, 30000);
}

const voyante = () => {
  setTimeout(function() {
    fetch(`/games/${gameId}/voyante_next_step`);
  }, 30000);
}

const loup = () => {
  setTimeout(function() {
    fetch(`/games/${gameId}/random_loup_vote`);
  }, 30000);
}

const sorciere = () => {
  setTimeout(function() {
    fetch(`/games/${gameId}/random_sorciere_vote`);
  }, 30000);
}

const chasseur = () => {
  setTimeout(function() {
    fetch(`/games/${game_id}/chasseur_random_kill`);
  }, 30000);
}

export { firstNight };
