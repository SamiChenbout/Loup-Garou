  class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def create
    @game = Game.find(params[:game_id])
    @player = @game.players.where(user_id: current_user.id)[0]
    @message = Message.new(message_params)
    @message.game = @game
    @message.player = @player
    if @message.save
      respond_to do |format|
        format.html { redirect_to game_path(@game) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'games/show' }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
