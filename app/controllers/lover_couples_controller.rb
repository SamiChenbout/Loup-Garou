class LoverCouplesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @lover1 = Player.find(params[:post][:lovers_ids][0])
    @lover2 = Player.find(params[:post][:lovers_ids][1])
    lover_couple = LoverCouple.new(lover1: @lover1, lover2: @lover2, game: @game)
    @lover1.update(is_link: true)
    @lover2.update(is_link: true)
    @game.update(round_step: "couple-reveal")
    lover_couple.save!
    broadcast_status(@game)
  end

  # CUPIDON
  def cupidon
    @game = Game.find(params[:game_id])
    @gamer = Player.where(user: current_user, game: @game).first
    @cupidon = Player.find_by(game: @game, character: Character.where(name: "cupidon"))
    all = @game.players
    @all_except_me = []
    @dead = []
    all.each do |player|
      @all_except_me << player if player.user != current_user && player.is_alive
      @dead << player if player.user != current_user && player.is_alive == false
    end
  end

  def random_couple_choose
    @game = Game.find(params[:game_id])
    if LoverCouple.where(game: @game).count == 0
      # Designing 2 lovers ramdomly
      @lovers = []
      user_1 = User.find(1)
      user_2 = User.find(2)
      @lovers << @game.players.where(user: user_1, game: @game).first
      @lovers << @game.players.where(user: user_2, game: @game).first
      @lover_couple = LoverCouple.new(lover1: @lovers[0], lover2: @lovers[1], game: @game)
      @lovers[0].update(is_link: true)
      @lovers[1].update(is_link: true)
      @lover_couple.save!
    end
    # TO DO: lover_couple.save!
    # Setting game round_step
    @game.update(round_step: "couple-reveal")
    broadcast_status(@game)
  end

  def destroy
    @lover_couple = LoverCouple.find(params[:lover_couple_id])
    @lover_couple.destroy
  end
end
