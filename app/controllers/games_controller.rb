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
    if Game.where(step: "waiting") != []
      @game = Game.where(step: "waiting").first
      @player = Player.new(user: current_user, game: @game)
    else
      @game = Game.new
      @player = Player.new(user: current_user, game: @game)
    end
      @game.save
      @player.save
      redirect_to game_path(@game)
  end

  def starting
    if Game.where(step: "waiting").players
  end
end
