class LoverCouplesController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    lover1 = Player.find_by(user: User.find_by(username: params[:lovers][:lovers_ids][1]), game: @game)
    lover2 = Player.find_by(user: User.find_by(username: params[:lovers][:lovers_ids][2]), game: @game)
    @lover_couple = LoverCouple.new(lover1: lover1, lover2: lover2)
    raise
    redirect_to game_path(@game)
  end

  # CUPIDON
  def cupidon
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @all_except_me = @game.players
  end
  def random_couple_choose
    @game = Game.find(params[:game_id])
    # Designing 2 lovers ramdomly
    @lovers = @game.players.sample(2)
    @lover_couple = LoverCouple.new(lover1: @lovers[0], lover2: @lovers[1])
    @lover_couple.save
    # Setting game round_step
    @game.round_step = "voyante"
    @game.save
  end

  def destroy
    @lover_couple = LoverCouple.find(params[:lover_couple_id])
    @lover_couple.destroy
  end
end
