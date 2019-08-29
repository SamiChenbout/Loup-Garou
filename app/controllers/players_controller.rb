class PlayersController < ApplicationController

  def find_game
    @characters = Character.all
    if Game.where(step: "waiting") != []
      @game = Game.where(step: "waiting").first
      roles = @game.characters
      @characters -= roles
      @player = Player.new(user: current_user, game: @game, character: @characters.sample)
    else
      @game = Game.new
      @player = Player.new(user: current_user, game: @game, character: @characters.sample)
    end
    @game.save
    @player.save
    broadcast_number_players(@game)
    if @game.players.count > 5
      @game.update(step: "starting")
      broadcast_status(@game)
      redirect_to game_cupidon_path(@game)
    else
      redirect_to game_path(@game)
    end
  end

  private

  def broadcast_number_players(game)
    ActionCable.server.broadcast("game_#{game.id}", {
      number_of_players: game.players.count
    })
  end

end
