class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players

    @sorciere = Player.where(game: @game, character: Character.where(name: "sorciere").first).first
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    @cupidon = Player.where(game: @game, character: Character.where(name: "cupidon").first).first
    @chasseur = Player.where(game: @game, character: Character.where(name: "chasseur").first).first
    @loup1 = Player.where(game: @game, character: Character.where(name: "loup").first).first
    @loup2 = Player.where(game: @game, character: Character.where(name: "loup").last).first
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
    @game.update(step: "starting") if @game.players.count > 5
    redirect_to game_path(@game)
  end
end
