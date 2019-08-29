class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @message = Message.new

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

  def end_game
    @alivewolves = []
    @aliveplayers = []
    @players.each do |player|
      if player.character.name == "loup" && player.is_alive == true
        @alivewolves << player
      elsif player.is_alive == true
        @aliveplayers << player
      end
    end
    if @wolves.count == @players.count
      return "Wolves win"
    elsif @wolves.count == 0
      return "Villagers win"
    else
      return "game continues"
    end
  end
end
