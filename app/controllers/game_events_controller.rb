class GameEventsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @user = User.find_by(username: params["game_event"]["target"].last)
    @game_event = GameEvent.new(target: Player.find_by(user: @user))
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = Player.where(game: @game, user: current_user).first
    @game_event.actor = @actor
    if @game.round_step == "day"
      @game_event.event_type = "villageois-vote"
    else
      if @actor.character.name == "sorciere"
        @game_event.event_type = "sorciere-kill"
        @game.update(round_step: "day")
      elsif @actor.character.name == "voyante"
        @game_event.event_type = "spy"
        @game.update(round_step: "loup")
      elsif @actor.character.name == "loup"
        @game_event.event_type = "loup-vote"
        @game.update(round_step: "day")
        @game.update(round_step: "sorciere")if @game.round == 1
      elsif @actor.character.name == "chasseur"
        @game_event.event_type = "sorciere-kill"
      end
    end
    @game_event.save
    broadcast_status(@game)
  end

  def destroy
    @game_event.destroy
  end

  # VOYANTE
  def voyante
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players
  end
  def voyante_next_step
    # Setting game round_step
    @game = Game.find(params[:game_id])
    @game.update(round_step: "loup")
    broadcast_status(@game)
  end

  # LOUP
  def loup
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players
  end
  def random_loup_choose
    # All players except current_user
    @game = Game.find(params[:game_id])
    @players = @game.players.where.not(user_id: current_user.id)
    # Designing a target ramdomly
    @target = @players.sample
    # Creating corresponding game event
    @game_event = GameEvent.new(target: @target)
    # Assigning game_event attributes before saving
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = Player.where(game: @game, user: current_user).first
    @game_event.actor = @actor
    @game_event.event_type = "loup-vote"
    @game_event.save
    # Setting game round_step
    if @game.round == 1
      @game.update(round_step: "sorciere")
    else
      @game.update(round_step: "day")
    end
    broadcast_status(@game)
  end

  # SORCIERE
  def sorciere
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players
  end
   def random_sorciere_choose
    # All players except current_user
    @game = Game.find(params[:game_id])
    @players = @game.players.where.not(user_id: current_user.id)
    # Designing a target ramdomly
    @target = @players.sample
    # Creating corresponding game event
    @game_event = GameEvent.new(target: @target)
    # Assigning game_event attributes before saving
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = Player.where(game: @game, user: current_user).first
    @game_event.actor = @actor
    @game_event.event_type = "sorciere-kill"
    @game_event.save
    # Setting game round_step
    # @game.round_step = "day"
    @game.update(round_step: "day")
    broadcast_status(@game)
  end

  # CHASSEUR
  def chasseur
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players
  end
  def random_chasseur_kill
    @game = Game.find(params[:game_id])
    @players = @game.players.where.not(user_id: current_user.id)
    # Designing a target ramdomly
    @target = @players.sample
    # Creating corresponding game event
    @game_event = GameEvent.new(target: @target)
    # Assigning game_event attributes before saving
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = Player.where(game: @game, user: current_user).first
    @game_event.actor = @actor
    @game_event.event_type = "sorciere-kill"
    @game_event.save
    # round_step is not changing
    broadcast_status(@game)
  end
end
