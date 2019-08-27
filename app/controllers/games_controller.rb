class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

  def find_game

    characters = Character.all
    if Game.where(step: "waiting") != []
      @game = Game.where(step: "waiting").first
      roles = @game.characters if @game.characters != nil
      characters -= roles
      @player = Player.new(user: current_user, game: @game)
    else
      @game = Game.new
      @player = Player.new(user: current_user, game: @game)
    end
      @game.save
      @player.character = characters.sample
      @player.save
      redirect_to game_path(@game)
  end

  def starting
    @waiting_games = Game.where(step: "waiting")
    @waiting_games.each do |game|
      game.step = "starting" if game.players.count > 5
    end
  end
end
