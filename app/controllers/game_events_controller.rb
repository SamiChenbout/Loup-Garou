class GameEventsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @user = User.find_by(username: params["game_event"]["target"].last)
    @game_event = GameEvent.new(target: Player.find_by(user: @user))
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = Player.where(game: @game, user: current_user).first
    @game_event.actor = @actor
    if @game.is_day?
      @game_event.event_type = "villageois-vote"
    else
      @game_event.event_type = "sorciere-kill" if @actor.character.name == "sorciere"
      @game_event.event_type = "spy" if @actor.character.name == "voyante"
      @game_event.event_type = "loup-vote" if @actor.character.name == "loup"
    end
    @game_event.save
    redirect_to game_path(@game)
  end

  def destroy
    @game_event.destroy
  end

  def couple
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players
  end
  # Actions triggered by default if no action taken
  def random_couple
    @game = Game.find(params[:game_id])
    # Designing 2 lovers ramdomly
    @lovers = @game.players.sample(2)
    @lover_couple = LoverCouple.new(lover1: @lovers[0], lover2: @lovers[1])
    @lover_couple.save
    # Setting game round_step
    @game.round_step = "voyante"
    @game.save
  end

  def voyante_next_step
    # Setting game round_step
    @game = Game.find(params[:game_id])
    @game.round_step = "loup"
    @game.save
  end

  def random_loup_vote
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
    @game_event.event_type = "Loup has designated a prey!"
    @game_event.save
    # Setting game round_step
    if @game.round == 1
      @game.round_step = "sorciere"
    else
      @game.round_step = "day"
    end
    @game.save
    redirect_to game_path(@game)
  end

   def random_sorciere_vote
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
    @game_event.event_type = "Sorciere has used its death potion!"
    @game_event.save
    # Setting game round_step
    # @game.round_step = "day"
    @game.save
    redirect_to game_path(@game)
  end

  def chasseur_random_kill
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
    @game_event.event_type = "Chasseur has shot someone down !"
    @game_event.save
    # round_step is not changing
    redirect_to game_path(@game)
  end
end
