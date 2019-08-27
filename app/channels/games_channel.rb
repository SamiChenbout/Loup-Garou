class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:game_id]}"
  end


  # TODO: DELETE unsubscribed method below
  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end
end
