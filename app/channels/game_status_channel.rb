class GameStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_status_#{params[:game_id]}"
  end
end
