class GameEventsController < ApplicationController

  def new
    @game_event = Game_event.new
  end

  def create
    @game = Game.find(params[:game_id])
    @game_event = Game_event.new(game_event_params)
    @game_event.game = @game
    @game_event.round = @game.round
    @actor = current_user
    @game_event.actor = @actor
    @game_event.save
  end

  def destroy
    @game_event.destroy
  end

  def event_type
    #CODE THIS SHIT LATER
  end

  private

  def game_event_params
    params.require(:game_event).permit(:target)
  end

end
