const randomCouple = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  if (gameDiv) {
    const gameId = gameDiv.dataset.gameId;
  }
  setTimeout(function() {
    fetch(`/game/${gameId}/random_couple`);
  }, 15000);
}

const voyante = () => {
  document.querySelector('.voyante').classList.remove('d-none')
  if (document.querySelector('.voyante').classList.contains('d-none')) {
     //GO TO NEXT STEP
  else
    setTimeout(function() {
        document.querySelector('.voyante').classList.add('d-none');
    }, 15000);
  }
}

const loups = () => {
  if (document.querySelector('.loups').classList.contains('d-none')) {
    // GO TO NEXT STEP
  else
    setTimeout(function() {
        document.querySelector('.loups').classList.remove('d-none');
    }, 30000);
  }
}
