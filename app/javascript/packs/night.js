const firstNight = () => {
  if(document.querySelector('.firstNight')) {
    randomCouple();
  };
}

const randomCouple = () => {
  document.querySelector('.cupidon').classList.remove('d-none');
  setTimeout(function() {
    document.querySelector('.button').click(function(){
      if (document.querySelector('.cupidon').hasClass("d-none") === false){
        $.ajax({
          type: "POST",
          url: "/games/<% @game.id %>/random_couple"
        });
      };
    })
  }, 15000);
}

const otherNight = () => {
  if(document.querySelector('.night')) {
    setTimeout(function() {
      document.querySelector('.voyante').classList.remove('d-none');
    }, 20000);
    setTimeout(function() {
      document.querySelector('.voyante').classList.add('d-none');
      document.querySelector('.loup').classList.remove('d-none');
    }, 30000);
    endOfNight();
  };
}

const endOfNight = () => {
  document.querySelector('.endOfNight').innerHTML = "<% @game.update(is_day: true) %>";
}


const voyante = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  if (gameDiv) {
    const gameId = gameDiv.dataset.gameId;
  }
  setTimeout(function() {
    fetch(`/games/${gameId}/voyante_next_step`);
  }, 15000);
}

const loups = () => {
  if (document.querySelector('.loups').classList.contains('d-none')) {
    GO TO NEXT STEP
  else
    setTimeout(function() {
        document.querySelector('.loups').classList.remove('d-none');
      }, 30000);
    }
  }


export { firstNight, otherNight, endOfNight };
