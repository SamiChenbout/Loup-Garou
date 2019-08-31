  class MessagesController < ApplicationController

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
    if @message.game.round_step == "loup" && @player.is_alive
      broadcast_loup_message
    elsif @player.is_alive
      broadcast_message
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def broadcast_message
    ActionCable.server.broadcast("game_#{@game.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/show",
        locals: { message: @message, author: false }
      ),
      current_user_id: current_user.id
    })
  end

  def broadcast_loup_message
    ActionCable.server.broadcast("loup_messages_#{@game.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/show",
        locals: { message: @message, author: false }
      ),
      current_user_id: current_user.id
    })
  end

end

