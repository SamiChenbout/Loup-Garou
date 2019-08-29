class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  def broadcast_status(game)
    ActionCable.server.broadcast("game_status_#{game.id}", {
      game_status: {
        step: game.step,
        round_step: game.round_step,
        round: game.round
      }
    })
  end
end
