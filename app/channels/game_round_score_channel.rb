class GameRoundScoreChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_round_score_#{params[:game_id]}"
  end
end
