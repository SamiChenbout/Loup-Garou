class LoverCouplesController < ApplicationController
  def create
    @lover_couple = Lover_couple.new(lover_params)
  end

  def destroy
    @lover_couple = Lover_couple.find(params[:lover_couple_id])
    @lover_couple.destroy
  end

  private

  def lover_params
    params.require(:lover_couple).permit(:lover1, :lover2)
  end
end
