class LoupMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "loup_messages_#{params[:game_id]}"
  end
end
