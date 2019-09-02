const mycheckTwo = () => {
  if(document.querySelector('.checkTwo')) {
    document.querySelectorAll('.mycheck').forEach(function(element) {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        let count = 0;
        document.querySelectorAll('.mycheck').forEach(function(thing) {
          if(thing.querySelector('input').checked) {
            count = count + 1;
          };
        });
        if(event.currentTarget.querySelector('input').checked === false && count < 2) {
          event.currentTarget.querySelector('label').classList.add('checked');
          event.currentTarget.querySelector('input').checked = true;
        } else if(event.currentTarget.querySelector('input').checked){
          event.currentTarget.querySelector('label').classList.remove('checked');
          event.currentTarget.querySelector('input').checked = false;
        };
      });
    });
  };
};

const mycheckOne = () => {
  if(document.querySelector('.checkOne')) {
    document.querySelectorAll('.mycheck').forEach(function(element) {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        document.querySelectorAll('.mycheck').forEach(function(thing) {
          thing.querySelector('label').classList.remove('checked');
          thing.querySelector('input').checked = false;
        });
        event.currentTarget.querySelector('label').classList.add('checked');
        event.currentTarget.querySelector('input').checked = true;
      });
    });
  };
};

const mycheckVoteLoup = () => {
  if(document.querySelector('.checkVoteLoup')) {
    document.querySelectorAll('.mycheck').forEach(function(element) {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        if(element.querySelector('input').checked === false) {
          document.querySelectorAll('.mycheck').forEach(function(thing) {
            if(thing.querySelector('input').checked) {
              if(thing.querySelector('.puce').innerText === "1") {
                thing.querySelector('.puce').innerText = "0";
              } else if(thing.querySelector('.puce').innerText === "2") {
                thing.querySelector('.puce').innerText = "1";
              }
              thing.querySelector('input').checked = false;
            }
          });
          if(element.querySelector('.puce').innerText === "0") {
            element.querySelector('.puce').innerText = "1";
            element.querySelector('input').checked = true;
          } else if(element.querySelector('.puce').innerText === "1") {
            element.querySelector('.puce').innerText = "2";
            element.querySelector('input').checked = true;
          }
        } else {
          if(element.querySelector('.puce').innerText === "1") {
            element.querySelector('.puce').innerText = "0";
            element.querySelector('input').checked = false;
          } else if(element.querySelector('.puce').innerText === "2") {
            element.querySelector('.puce').innerText = "1";
            element.querySelector('input').checked = false;
          }
        }
        document.querySelectorAll('.mycheck').forEach(function(truc) {
          if(truc.querySelector('.puce').innerText === "0") {
            truc.querySelector('.puce').classList.add('d-none');
          } else if(truc.querySelector('.puce').innerText != "0") {
            truc.querySelector('.puce').classList.remove('d-none');
          }
        });
      });
    });
  };
};

const mycheckVote = () => {
  if(document.querySelector('.checkVote')) {
    const numberDiv = document.getElementById("info-number-player-alive");
    const number = numberDiv.dataset.numberId;
    document.querySelectorAll('.mycheck').forEach(function(element) {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        if(element.querySelector('input').checked === false) {
          document.querySelectorAll('.mycheck').forEach(function(thing) {
            if(thing.querySelector('input').checked) {
              let count = parseInt(thing.querySelector('.puce').innerText, 10);
              thing.querySelector('.puce').innerText = (count - 1).toString();
              thing.querySelector('input').checked = false;
            }
          });
          let county = parseInt(element.querySelector('.puce').innerText, 10);
          if(county < number) {
            element.querySelector('.puce').innerText = (county + 1).toString();
            element.querySelector('input').checked = true;
          }
        } else {
          element.querySelector('.puce').innerText = (county - 1).toString();
          element.querySelector('input').checked = false;
        }
        document.querySelectorAll('.mycheck').forEach(function(truc) {
          if(truc.querySelector('.puce').innerText === "0") {
            truc.querySelector('.puce').classList.add('d-none');
          } else if(truc.querySelector('.puce').innerText != "0") {
            truc.querySelector('.puce').classList.remove('d-none');
          }
        });
      });
    });
  };
};

const autoSubmit = () => {
  if (document.getElementById("new_game_event")) {
    document.querySelectorAll(".mycheck").forEach((element) => {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        document.getElementById("new_game_event").submit();
      });
    });
  }
}

const scoreUpdate = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  if (gameDiv) {
    const gameId = gameDiv.dataset.gameId;
    App[`game_round_score_${gameId}`] = App.cable.subscriptions.create(
      { channel: 'GameRoundScoreChannel', game_id: gameId },
        { received: (data) => {
          console.log(data);
          document.querySelectorAll(".mycheck").forEach((player) => {
            if (data.new_target_id === parseInt(player.dataset.playerId, 10)) {
              player.querySelector('.puce').innerText = data.updated_vote_new_target;
              if (data.updated_vote_new_target > 0) {
                player.querySelector('.puce').classList.remove("d-none");
              } else if (data.updated_vote_new_target === 0) {
                player.querySelector('.puce').classList.add("d-none");
              }
            } else if (data.old_target_id === parseInt(player.dataset.playerId, 10)) {
              player.querySelector('.puce').innerText = data.updated_vote_previous_target;
              if (data.updated_vote_previous_target > 0) {
                player.querySelector('.puce').classList.remove("d-none");
              } else if (data.updated_vote_previous_target === 0) {
                player.querySelector('.puce').classList.add("d-none");
              }
            }
          });
        }
      }
    )
  }
}

export { scoreUpdate, autoSubmit, mycheckTwo, mycheckOne, mycheckVoteLoup, mycheckVote };
