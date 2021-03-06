const initActionCable = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  if (gameDiv) {
    const gameId = gameDiv.dataset.gameId;
    App[`game_${gameId}`] = App.cable.subscriptions.create(
      { channel: 'GamesChannel', game_id: gameId },
        { received: (data) => {
          console.log(data);
          const numberPlayerSpan = document.getElementById("number-players");
          const currentUserId = parseInt(gameDiv.dataset.currentUserId, 10);
          const messageDiv = document.getElementById("messages");
          if (numberPlayerSpan) {
            document.getElementById("number-players").innerText = data.number_of_players;
          };
          if (messageDiv) {
            if (data.current_user_id !== currentUserId) {
            messageDiv.insertAdjacentHTML('beforeend', data.message_partial);
             scrollLastMessageIntoView();
            }
          }
        }
      }
    )
    App[`game_status_${gameId}`] = App.cable.subscriptions.create(
      { channel: 'GameStatusChannel', game_id: gameId },
      { received: redirectAllPlayers }
    )
  }
}

// SCROLL FUNCTION
const scrollLastMessageIntoView = () => {
  const messages = document.querySelectorAll('.message-content');
  const lastMessage = messages[messages.length - 1];
  if (lastMessage !== undefined) {
    lastMessage.scrollIntoView();
  }
}

// GAME REDIRECTION FUNCTION
const redirectAllPlayers = (data) => {
  if (data.game_status.step === "starting") {
    if (data.game_status.round_step === "cupidon" && data.game_status.round === 1) {
      window.location = `/games/${data.game_id}/cupidon`;
    } else if (data.game_status.round_step === "voyante") {
      window.location = `/games/${data.game_id}/voyante`;
    } else if (data.game_status.round_step === "loup") {
      window.location = `/games/${data.game_id}/loup`;
    } else if (data.game_status.round_step === "sorciere" && data.game_status.round === 1) {
      window.location = `/games/${data.game_id}/sorciere`;
    } else if (data.game_status.round_step === "day") {
      window.location = `/games/${data.game_id}`;
    } else if (data.game_status.round_step === "start-day") {
      window.location = `/games/${data.game_id}/day`;
    } else if (data.game_status.round_step === "end-day") {
      window.location = `/games/${data.game_id}/end-day-calcul`;
    } else if (data.game_status.round_step === "chasseur") {
      window.location = `/games/${data.game_id}/chasseur`;
    } else if (data.game_status.round_step === "show-role") {
      window.location = `/games/${data.game_id}/role`;
    } else if (data.game_status.round_step === "nuit-interlude") {
      window.location = `/games/${data.game_id}/night`;
    } else if (data.game_status.round_step === "day-interlude") {
      window.location = `/games/${data.game_id}/day`;
    } else if (data.game_status.round_step === "couple-reveal") {
      window.location = `/games/${data.game_id}/couple`;
    } else if (data.game_status.round_step === "reveal") {
      window.location = `/games/${data.game_id}/reveal`;
    }
  } else if (data.game_status.step === "finished") {
    window.location = `/games/${data.game_id}/end_game`;
  }
}

export { initActionCable, scrollLastMessageIntoView }
