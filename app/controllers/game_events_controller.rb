class GameEventsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @user = User.find_by(username: params["game_event"]["target"])
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
        @game.update(round_step: "sorciere") if @game.round == 1
      elsif @actor.character.name == "chasseur"
        @actor.update(is_alive: false)
        if @actor.is_link
          duo = LoverCouple.find_by(game: @game)
          duo.lover1.update(is_alive: false)
          duo.lover2.update(is_alive: false)
        end
        if @game_event.target.is_link
          duo = LoverCouple.find_by(game: @game)
          duo.lover1.update(is_alive: false)
          duo.lover2.update(is_alive: false)
        end
        @game_event.event_type = "chasseur-kill"
        @game.update(round_step: "day") if @actor.state_chasseur == "dead-start"
        @game.update(news: "#{@actor.user.username}, le chasseur, a tué #{@game_event.target.user.username}, qui était #{@game_event.target.character.name}.")
        @actor.update(state_chasseur: "peace")
      end
    end
    @game_event.save
    broadcast_status(@game)
  end

  def destroy
    @game_event.destroy
  end

  def when_day_comes
    @game = Game.find(params[:game_id])
    @game.update(news: "")
    victimes_loup = GameEvent.where(game: @game, round: @game.round, event_type: "loup-vote")
    victime1 = (victimes_loup.sample).target
    victime1.update(is_alive: false)
    if victime1.is_link
      duo = LoverCouple.find_by(game: @game)
      duo.lover1.update(is_alive: false)
      duo.lover2.update(is_alive: false)
      duo.lover1.update(state_chasseur: "dead-start") if duo.lover1.character.name == "chasseur"
      duo.lover2.update(state_chasseur: "dead-start") if duo.lover2.character.name == "chasseur"
    end
    victime1.update(state_chasseur: "dead-start") if victime1.character.name == "chasseur"
    @game.update(news: @game.news + "Les amoureux ont été liés !\n") if @game.round == 1
    if GameEvent.where(game: @game, round: @game.round, event_type: "spy") != []
      decouvert = GameEvent.where(game: @game, round: @game.round, event_type: "spy").first.target
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
      if victime2.is_link
        duo = LoverCouple.find_by(game: @game)
        duo.lover1.update(is_alive: false)
        duo.lover2.update(is_alive: false)
        duo.lover1.update(state_chasseur: "dead-start") if duo.lover1.character.name == "chasseur"
        duo.lover2.update(state_chasseur: "dead-start") if duo.lover2.character.name == "chasseur"
      end
      victime2.update(state_chasseur: "dead-start") if victime2.character.name == "chasseur"
      @game.update(news: @game.news + "   - #{victime2.user.username}, qui était #{victime2.character.name}.\n") if victime2 != victime1
    end
    @game.update(news: @game.news + "   - #{victime1.user.username}, qui était #{victime1.character.name}.\n")
    @game.update(round_step: "day")
    alivewolves = []
    aliveplayers = []
    players = []
    wolfs = []
    allalive = []
    @game.players.each do |player|
      if player.is_alive
        alivewolves << player if player.character.name == "loup"
        aliveplayers << player if player.character.name != "loup"
        allalive << player
      end
      wolfs << player if player.character.name == "loup"
      players << player if player.character.name != "loup"
    end
    lovers = Player.where(game: @game, is_link: true)
    if (lovers & allalive) == allalive
      lovers[0].update(points: 700)
      lovers[1].update(points: 700)
      @game.update(news: @game.news + "The couple win!", step: "finished")
    elsif alivewolves.count == 0
      players.each do |villagoie|
        villagoie.update(points: 250)
        villagoie.update(points: 500) if villagoie.is_alive
      end
      @game.update(news: @game.news + "The villagoies win!", step: "finished")
    elsif alivewolves.count == aliveplayers && alivewolves.count == 1
      wolfs.each do |loup|
        loup.update(points: 250)
        loup.update(points: 500) if loup.is_alive
      end
      @game.update(news: @game.news + "The werewolfs win!", step: "finished")
    end
    broadcast_status(@game)
  end

  def when_night_comes
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
    victimes = GameEvent.where(game: @game, round: @game.round, event_type: "villageois-vote")
    count = {}
    victimes.each do |myvictime|
      if count.key?(myvictime.target.user.username)
        count[myvictime.target.user.username] += 1
      else
        count[myvictime.target.user.username] = 1
      end
    end
    victime = victimes.sort_by { |_key, value| value }.first
    player = Player.where(game: @game, user: User.find_by(username: victime.target.user.username)).first
    player.update(is_alive: false)
    if player.is_link
      duo = LoverCouple.find_by(game: @game)
      duo.lover1.update(is_alive: false)
      duo.lover2.update(is_alive: false)
      duo.lover1.update(state_chasseur: "dead-end") if duo.lover1.character.name == "chasseur"
      duo.lover2.update(state_chasseur: "dead-end") if duo.lover2.character.name == "chasseur"
    end
    @game.update(news: "#{player.user.username}, ")
    if player.character.name == "loup" || player.character.name == "chasseur"
      @game.update(news: @game.news + "le #{player.character.name}, est mort!")
    else
      @game.update(news: @game.news + "la #{player.character.name}, est morte!")
    end
    player.update(state_chasseur: "dead-end") if player.character.name == "chasseur"
    @game.update(round: @game.round + 1)
  end

  def when_night_talk
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
    @chasseur = Player.where(game: @game, character: Character.where(name: "chasseur").first).first
    voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    if voyante.is_alive
      @game.update(round_step: "voyante")
    else
      @game.update(round_step: "loup")
    end
    alivewolves = []
    aliveplayers = []
    players = []
    wolfs = []
    allalive = []
    @game.players.each do |player|
      if player.is_alive
        alivewolves << player if player.character.name == "loup"
        aliveplayers << player if player.character.name != "loup"
        allalive << player
      end
      wolfs << player if player.character.name == "loup"
      players << player if player.character.name != "loup"
    end
    lovers = Player.where(game: @game, is_link: true)
    if (lovers & allalive) == allalive
      lovers[0].update(points: 700)
      lovers[1].update(points: 700)
      @game.update(news: @game.news + "The couple win!", step: "finished")
    elsif alivewolves.count == 0
      players.each do |villagoie|
        villagoie.update(points: 250)
        villagoie.update(points: 500) if villagoie.is_alive
      end
      @game.update(news: @game.news + "test", step: "finished")
    elsif alivewolves.count == aliveplayers && alivewolves.count == 1
      wolfs.each do |loup|
        loup.update(points: 250)
        loup.update(points: 500) if loup.is_alive
      end
      @game.update(news: @game.news + "The werewolfs win!", step: "finished")
    end
    broadcast_status(@game)
  end

  # -------------------------------------------------

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
    @game_event.event_type = "chasseur-kill"
    @game_event.save
    # round_step is not changing
    @actor.update(state_chasseur: "peace")
    broadcast_status(@game)
  end
end
