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
        @game.update(round_step: "start-day")
      elsif @actor.character.name == "voyante"
        @game_event.event_type = "spy"
        @game.update(round_step: "loup")
      elsif @actor.character.name == "loup"
        @game_event.event_type = "loup-vote"
        @game.update(round_step: "start-day")
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

  def whenDayComes
    @game = Game.find(params[:game_id])
    @game.update(news: "")
    victimes_loup = GameEvent.where(game: @game, round: @game.round, event_type: "loup-vote")
    victime1 = (victimes_loup.sample).target
    victime1.update(is_alive: false)
    @game.update(news: @game.news + "Les amoureux ont été liés !\n") if @game.round == 1
    if GameEvent.where(game: @game, round: @game.round, event_type: "spy") != []
      decouvert = GameEvent.where(game: @game, round: @game.round, event_type: "loup-vote").first.target
      @game.update(news: @game.news + "La voyante a espionnée ")
      if decouvert.character.name == "loup" || decouvert.character.name == "chasseur"
        @game.update(news: @game.news + "le ")
      else
        @game.update(news: @game.news + "la ")
      end
      @game.update(news: @game.news + "#{decouvert.character.name}.\n")
    end
    @game.update(news: @game.news + "Le village a subit des pertes :\n")
    if @game.round == 1
      victime2 = GameEvent.where(game: @game, round: @game.round, event_type: "sorciere-kill").first.target
      victime2.update(is_alive: false)
      @game.update(news: @game.news + "   - #{victime2.user.username}, qui était #{victime2.character.name}.\n") if victime2 != victime1
    end
    @game.update(news: @game.news + "   - #{victime1.user.username}, qui était #{victime1.character.name}.\n")
    @game.update(round_step: "day")
    broadcast_status(@game)
  end

  def whenNightComes
    @game = Game.find(params[:game_id])
    victimes = GameEvent.where(game: @game, round: @game.round, event_type: "villageois-vote")
    count = {}
    victimes.each do |victime|
      if count.key?(victime.user.username)
        count[victime.user.username] += 1
      else
        count[victime.user.username] = 1
      end
    end
    victime = victimes.max_by { |_key, value| value }.first
    player = Player.where(game: @game, user: User.find_by(username: victime)).first
    player.update(is_alive: false)
    @game.update(news: "#{player.user.username}, ")
    if player.character.name == "loup" || player.charcter.name == "chasseur"
      @game.update(news: @game.news + "le ")
    else
      @game.update(news: @game.news + "la ")
    end
    @game.update(news: "#{player.character.name}, est mort!")
    redirect_to game_end_day_path(@game)
    broadcast_status(@game)
  end

  def whenNightTalk
    @game = Game.find(params[:game_id])
    sleep(10_000)
    @game.update(round_step: "voyante")
    broadcast_status(@game)
  end

  # VOYANTE
  def voyante
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
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
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
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
      @game.update(round_step: "start-day")
    end
    broadcast_status(@game)
  end

  # SORCIERE
  def sorciere
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
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
    @game.update(round_step: "start-day")
    broadcast_status(@game)
  end

  # CHASSEUR
  def chasseur
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
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
