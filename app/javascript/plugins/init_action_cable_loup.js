const initActionCableLoup = () => {
  const gameDiv = document.getElementById("connect-to-game-channel");
  if (gameDiv) {
    const gameId = gameDiv.dataset.gameId;
    App[`loup_messages_${gameId}`] = App.cable.subscriptions.create(
      { channel: 'LoupMessagesChannel', game_id: gameId },
      { received: (data) => {
        console.log(data);
        const currentUserId = parseInt(gameDiv.dataset.currentUserId, 10);
        const loupMessageDiv = document.getElementById("loup_messages");
        if (loupMessageDiv) {
          if (data.current_user_id !== currentUserId) {
            loupMessageDiv.insertAdjacentHTML('beforeend', data.message_partial);
          }
        }
      }}
    )
  }
}

export { initActionCableLoup }
