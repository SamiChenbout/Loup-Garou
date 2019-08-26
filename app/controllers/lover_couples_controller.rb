class LoverCouplesController < ApplicationController
  def create
    @lover_couple = Lover_couple.new(lover_params)
  end

  private

  def lover_params
    params.require(:lover_couple).permit(:lover1, :lover2)
  end
end
