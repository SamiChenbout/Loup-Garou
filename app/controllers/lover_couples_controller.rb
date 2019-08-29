class LoverCouplesController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    lover1 = Player.find_by(user: User.find_by(username: params[:lovers][:lovers_ids][1]), game: @game)
    lover2 = Player.find_by(user: User.find_by(username: params[:lovers][:lovers_ids][2]), game: @game)
    lover_couple = LoverCouple.new(lover1: lover1, lover2: lover2)
    lover1.update(is_link: true)
    lover2.update(is_link: true)
    @game.update(round_step: "voyante")
    lover_couple.save
    broadcast_status(@game)
  end

  # CUPIDON
  def cupidon
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    all = @game.players
    @all_except_me = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
    end
  end
  def random_couple_choose
    @game = Game.find(params[:game_id])
    # Designing 2 lovers ramdomly
    @lovers = @game.players.sample(2)
    @lover_couple = LoverCouple.new(lover1: @lovers[0], lover2: @lovers[1])
    lovers[0].update(is_link: true)
    lovers[1].update(is_link: true)
    @lover_couple.save!
    # TO DO: lover_couple.save!
    # Setting game round_step
    @game.update(round_step: "voyante")
    broadcast_status(@game)
  end

  def destroy
    @lover_couple = LoverCouple.find(params[:lover_couple_id])
    @lover_couple.destroy
  end
end
