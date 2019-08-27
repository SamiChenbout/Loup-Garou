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
end
