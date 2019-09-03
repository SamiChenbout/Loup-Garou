class GameEventsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @game_event = GameEvent.new(target: Player.find(params[:target]))
    @game_event.game = @game
    @targeted_player = Player.find(params[:target])
    @user = @targeted_player.user
    @game_event.round = @game.round
    @actor = Player.where(game: @game, user: current_user).first
    @game_event.actor = @actor
    # WHEN STEP IS DAY, THEN BROADCAST RESULTS OF VOTE IN REAL TIME
    if @game.round_step == "day"
      @game_event.event_type = "villageois-vote"
      previous_current_user_vote_event = GameEvent.where(actor_id: @actor.id, event_type: "villageois-vote", round: @game.round)
      if previous_current_user_vote_event != []
        @previous_target_id = Player.find(previous_current_user_vote_event.last.target_id).id
      else
        @previous_target_id = 0
      end
      previous_current_user_vote_event.each do |previous_vote|
        previous_vote.destroy
      end
    @game_event.save
    return broadcast_score
    else
      # WHEN STEP IS NOT DAY
      if @actor.character.name == "sorciere"
        @game_event.event_type = "sorciere-kill"
        @game.update(round_step: "day-interlude")
      elsif @actor.character.name == "voyante"
        @game_event.event_type = "spy"
        @game.update(round_step: "reveal")
      elsif @actor.character.name == "loup"
        @game_event.event_type = "loup-vote"
        @game.update(round_step: "day-interlude")
        @game.update(round_step: "sorciere") if @game.round == 1
      elsif @actor.character.name == "chasseur"
        @actor.update(is_alive: false)
        @game_event.event_type = "chasseur-kill"
        @game.update(round_step: "day") if @actor.state_chasseur == "dead-start"
        @game.update(round_step: "night") if @actor.state_chasseur == "dead-end"
        @game.update(news: "#{@actor.user.username}, le chasseur, a tué #{@game_event.target.user.username}, qui était #{@game_event.target.character.name}.$")
        if GameEvent.find_by(game: @game, event_type: "villageois-vote", round: @game.round) == nil
          @actor.update(state_chasseur: "#{@game.round}-start")
        else
          @actor.update(state_chasseur: "#{@game.round}-end")
        end
        if @actor.is_link
          duo = LoverCouple.find_by(game: @game)
          duo.lover1.update(is_alive: false)
          duo.lover2.update(is_alive: false)
          @game.update(news: @game.news + "Dans la mort sont désormais réunis #{duo.lover1.user.username} et #{duo.lover2.user.username}!$") unless @game.news.include?("réunis")
        end
        if @game_event.target.is_link
          duo = LoverCouple.find_by(game: @game)
          duo.lover1.update(is_alive: false)
          duo.lover2.update(is_alive: false)
          @game.update(news: @game.news + "Dans la mort sont désormais réunis #{duo.lover1.user.username} et #{duo.lover2.user.username}!$") unless @game.news.include?("réunis")
        end
      end
      @game_event.save!
    end
    broadcast_status(@game) #unless @game.round_step == "day"
  end

  def broadcast_score
    ActionCable.server.broadcast("game_round_score_#{@game.id}", {
      game_id: @game.id,
      game_round: @game.round,
      new_target_id: @targeted_player.id,
      old_target_id: @previous_target_id,
      updated_vote_new_target: GameEvent.where(target_id: @targeted_player.id, event_type: "villageois-vote", game: @game, round: @game.round).count,
      updated_vote_previous_target: GameEvent.where(target_id: @previous_target_id, event_type: "villageois-vote", game: @game, round: @game.round).count,
    })
  end

  def destroy
    @game_event.destroy
  end

  def when_day_comes
    @game = Game.find(params[:game_id])
    @game.update(news: "")
    @sorciere = Player.where(game: @game, character: Character.where(name: "sorciere").first).first
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    @cupidon = Player.where(game: @game, character: Character.where(name: "cupidon").first).first
    @loup = Player.where(game: @game, character: Character.where(name: "loup").first).first
    @game.update(round_step: "day")
    victimes_loup = GameEvent.where(game: @game, round: @game.round, event_type: "loup-vote", actor: loup).first
    victime1 = victimes_loup.target
    victime1.update(is_alive: false)
    GameEvent.where(game: @game, round: @game.round, event_type: "loup-vote").each { |event| event.update(target: victime1) }
    if victime1.is_link
      duo = LoverCouple.find_by(game: @game)
      duo.lover1.update(is_alive: false)
      duo.lover2.update(is_alive: false)
      duo.lover1.update(state_chasseur: "dead-start") if duo.lover1.character.name == "chasseur"
      duo.lover2.update(state_chasseur: "dead-start") if duo.lover2.character.name == "chasseur"
      @game.update(round_step: "chasseur") if duo.lover2.character.name == "chasseur" || duo.lover1.character.name == "chasseur"
      @game.update(news: @game.news + "Dans la mort sont désormais réunis #{duo.lover1.user.username} et #{duo.lover2.user.username}!$") unless @game.news.include?("réunis")
    end
    victime1.update(state_chasseur: "dead-start") if victime1.character.name == "chasseur"
    @game.update(round_step: "chasseur") if victime1.character.name == "chasseur"
    if GameEvent.where(game: @game, round: @game.round, event_type: "spy") != []
      decouvert = GameEvent.where(game: @game, round: @game.round, event_type: "spy", actor: @voyante).first.target
      @game.update(news: @game.news + "La voyante a espionné ")
      if decouvert.character.name == "loup" || decouvert.character.name == "chasseur"
        @game.update(news: @game.news + "le ")
      else
        @game.update(news: @game.news + "la ")
      end
      @game.update(news: @game.news + "#{decouvert.character.name}.$")
    end
    @game.update(news: @game.news + "Le village a subit des pertes :$")
    if @game.round == 1
      victime2 = GameEvent.where(game: @game, round: @game.round, event_type: "sorciere-kill", actor: @sorciere).first.target
      victime2.update(is_alive: false)
      if victime2.is_link
        duo = LoverCouple.find_by(game: @game)
        duo.lover1.update(is_alive: false)
        duo.lover2.update(is_alive: false)
        duo.lover1.update(state_chasseur: "dead-start") if duo.lover1.character.name == "chasseur"
        duo.lover2.update(state_chasseur: "dead-start") if duo.lover2.character.name == "chasseur"
        @game.update(round_step: "chasseur") if duo.lover2.character.name == "chasseur" || duo.lover1.character.name == "chasseur"
        @game.update(news: @game.news + "Dans la mort sont désormais réunis #{duo.lover1.user.username} et #{duo.lover2.user.username}!$") unless @game.news.include?("réunis")
      end
      victime2.update(state_chasseur: "dead-start") if victime2.character.name == "chasseur"
      @game.update(round_step: "chasseur") if victime2.character.name == "chasseur"
      @game.update(news: @game.news + "#{victime2.user.username}, qui était #{victime2.character.name}.$") if victime2 != victime1
    end
    @game.update(news: @game.news + "#{victime1.user.username}, qui était #{victime1.character.name}.$")
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
      @game.update(step: "finished")
      @game.update(news: @game.news + "The couple win!$") unless @game.news.include?("win")
    elsif alivewolves.count == 0
      players.each do |villageois|
        villageois.update(points: 250)
        villageois.update(points: 500) if villageois.is_alive
      end
      @game.update(step: "finished")
      @game.update(news: @game.news + "The villageois win!$") unless @game.news.include?("win")
    elsif (alivewolves.count == aliveplayers.count && alivewolves.count == 1) || alivewolves.count > aliveplayers.count
      wolfs.each do |loup|
        loup.update(points: 250)
        loup.update(points: 500) if loup.is_alive
      end
      @game.update(step: "finished")
      @game.update(news: @game.news + "The werewolfs win!$") unless @game.news.include?("win")
    end
    if @game.step == "finished"
      redirect_to game_end_game_path(@game)
    else
      redirect_to game_path(@game)
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
    player.update(state_chasseur: "dead-end") if player.character.name == "chasseur"
    @game.update(round_step: "chasseur") if player.character.name == "chasseur"
    GameEvent.where(game: @game, round: @game.round, event_type: "villageois-vote").each { |event| event.update(target: player) }
    if player.is_link
      duo = LoverCouple.find_by(game: @game)
      duo.lover1.update(is_alive: false)
      duo.lover2.update(is_alive: false)
      duo.lover1.update(state_chasseur: "dead-end") if duo.lover1.character.name == "chasseur"
      duo.lover2.update(state_chasseur: "dead-end") if duo.lover2.character.name == "chasseur"
      @game.update(round_step: "chasseur") if duo.lover2.character.name == "chasseur" || duo.lover1.character.name == "chasseur"
      @game.update(news: @game.news + "Dans la mort sont désormais réunis #{duo.lover1.user.username} et #{duo.lover2.user.username}!$") unless @game.news.include?("réunis")
    end
    @game.update(news: "#{player.user.username}, ")
    if player.character.name == "voyante" || player.character.name == "sorciere"
      @game.update(news: @game.news + "la #{player.character.name}, est morte!$")
    else
      @game.update(news: @game.news + "le #{player.character.name}, est mort!$")
    end
  end

  def when_night_talk
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
    @chasseur = Player.where(game: @game, character: Character.where(name: "chasseur").first).first
    voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    @game.update(round_step: "nuit-interlude")
    chasseur = Character.find_by(name: "chasseur")
    @game.update(round_step: "chasseur") if Player.find_by(character: chasseur, game: @game).state_chasseur == "dead-end"
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
      @game.update(step: "finished")
      @game.update(news: @game.news + "The couple win!$") unless @game.news.include?("win")
    elsif alivewolves.count == 0
      players.each do |villageois|
        villageois.update(points: 250)
        villageois.update(points: 500) if villageois.is_alive
      end
      @game.update(step: "finished")
      @game.update(news: @game.news + "The villageois win!$") unless @game.news.include?("win")
    elsif (alivewolves.count == aliveplayers.count && alivewolves.count == 1) || alivewolves.count > aliveplayers.count
      wolfs.each do |loup|
        loup.update(points: 250)
        loup.update(points: 500) if loup.is_alive
      end
      @game.update(step: "finished")
      @game.update(news: @game.news + "The werewolfs win!$") unless @game.news.include?("win")
    end
    broadcast_status(@game)
  end

  # -------------------------------------------------

  # VOYANTE
  def voyante
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @voyante = Player.where(game: @game, character: Character.where(name: "voyante").first).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
  end

  def voyante_next_step
    # Setting game round_step
    @game = Game.find(params[:game_id])
    @game.update(round_step: "loup")
    broadcast_status(@game)
    redirect_to()
  end

  # LOUP
  def loup
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @loup1 = Player.where(game: @game, character: Character.where(name: "loup").first).first
    @loup2 = Player.where(game: @game, character: Character.where(name: "loup").last).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
  end
  def random_loup_choose
    # All players except current_user
    @game = Game.find(params[:game_id])
    @loup1 = Player.where(game: @game, character: Character.where(name: "loup").first).first
    @loup2 = Player.where(game: @game, character: Character.where(name: "loup").last).first
    @players = @game.players.where.not(user_id: @loup1.user.id)
    @players = @players.where.not(user_id: @loup2.user.id)
    # Designing a target ramdomly
    @target = @players.sample
    # Creating corresponding game event
    @game_event = GameEvent.new(target: @target)
    # Assigning game_event attributes before saving
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = Player.where(game: @game, character: Character.where(name: "loup").first).first
    @game_event.actor = @actor
    @game_event.event_type = "loup-vote"
    @game_event.save
    # Setting game round_step
    if @game.round == 1
      @game.update(round_step: "sorciere")
    else
      @game.update(round_step: "day-interlude")
    end
    broadcast_status(@game)
  end

  # SORCIERE
  def sorciere
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @sorciere = Player.where(game: @game, character: Character.where(name: "sorciere").first).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
  end
   def random_sorciere_choose
    # All players except current_user
    @game = Game.find(params[:game_id])
    @actor = Player.where(game: @game, character: Character.where(name: "sorciere").first).first
    @players = @game.players.where.not(user_id: @actor.id)
    # Designing a target ramdomly
    @target = @players.sample
    # Creating corresponding game event
    @game_event = GameEvent.new(target: @target)
    # Assigning game_event attributes before saving
    @game_event.game = @game
    @game_event.round = @game.round
    @game_event.actor = @actor
    @game_event.event_type = "sorciere-kill"
    @game_event.save
    # Setting game round_step
    # @game.round_step = "day"
    @game.update(round_step: "day-interlude")
    broadcast_status(@game)
  end

  # CHASSEUR
  def chasseur
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @chasseur = Player.where(game: @game, character: Character.where(name: "chasseur").first).first
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive && @chasseur.is_link == false || (player.is_link == false && @chasseur.is_link && player.is_alive)
      @dead << player if player.user != current_user && player.is_alive == false
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
    @actor = Player.where(game: @game, character: Character.where(name: "chasseur").first).first
    @game_event.actor = @actor
    @game_event.event_type = "chasseur-kill"
    @game_event.save
    @game.update(round_step: "day") if @actor.state_chasseur == "dead-start"
    @game.update(round_step: "night") if @actor.state_chasseur == "dead-end"
    if GameEvent.find_by(game: @game, event_type: "villageois-vote", round: @game.round) == nil
      @actor.update(state_chasseur: "#{@game.round}-start")
    else
      @actor.update(state_chasseur: "#{@game.round}-end")
    end
    broadcast_status(@game)
  end
end
