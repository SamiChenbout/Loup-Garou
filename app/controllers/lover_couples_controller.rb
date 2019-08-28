class LoverCouplesController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    lover1 = Player.find_by(user: User.find_by(username: params[:lovers][:lovers_ids][1]), game: @game)
    lover2 = Player.find_by(user: User.find_by(username: params[:lovers][:lovers_ids][2]), game: @game)
    @lover_couple = LoverCouple.new(lover1: lover1, lover2: lover2)
    redirect_to game_path(@game)
  end

  def destroy
    @lover_couple = LoverCouple.find(params[:lover_couple_id])
    @lover_couple.destroy
  end
end
