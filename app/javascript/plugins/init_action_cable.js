const initActionCable = () => {
  // Calling the ad hoc game div defined in game show
  const gameDiv = document.getElementById("connect-to-game-channel");
  if (gameDiv) {
    // Getting game id back from the ad hoc game div defined in game show
    const gameId = gameDiv.dataset.gameId;
    // Subscribing game players/users into same cable
    App[`game_${gameId}`] = App.cable.subscriptions.create(
      { channel: 'GamesChannel', game_id: gameId },
      { received: (data) => {
        // Avoiding to show user sent message twice (because of AJAX)
        const currentUserId = parseInt(gameDiv.dataset.currentUserId, 10);
        if (data.current_user_id !== currentUserId) {
        document.getElementById("messages").insertAdjacentHTML('beforeend', data.message_partial);

      }}}
    )
  }
}

export { initActionCable }
