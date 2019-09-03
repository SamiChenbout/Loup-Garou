class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @message = Message.new

    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end

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
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @chasseur = Player.where(game: @game, character: Character.where(name: "chasseur").first).first
    @sorciere = Player.where(game: @game, character: Character.where(name: "sorciere").first).first
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    @cupidon = Player.where(game: @game, character: Character.where(name: "cupidon").first).first
    @loup1 = Player.where(game: @game, character: Character.where(name: "loup").first).first
    @loup2 = Player.where(game: @game, character: Character.where(name: "loup").last).first
    @lovers = @game.lover_couples.first

    current_user.update(points: current_user.points + @gamer.points) if current_user.points != nil
    current_user.update(points: @gamer.points) unless current_user.points != nil
    current_user.update(level: current_user.level + 1, points: current_user.points / 1000) if current_user.points != nil && current_user.points / 1000 > 1

    @alivewolves = []
    @aliveplayers = []
    @players = []
    @wolfs = []
    @allalive = []
    @game.players.each do |player|
      if player.is_alive
        @alivewolves << player if player.character.name == "loup"
        @aliveplayers << player if player.character.name != "loup"
        @allalive << player
      end
      @wolfs << player if player.character.name == "loup"
      @players << player if player.character.name != "loup"
    end
    @lovers = Player.where(game: @game, is_link: true)
  end

  def role
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
  end

  def day
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
  end

  def night
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    @game.update(round: @game.round + 1)
  end

  def couple
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
    @lovers = LoverCouple.where(game: @game).first
    @cupidon = Player.where(game: @game, character: Character.where(name: "cupidon").first).first
  end

  def reveal
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    @target = GameEvent.where(game: @game, actor: @voyante, event_type: "spy", round: @game.round).first.target
  end
end
