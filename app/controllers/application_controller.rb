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
      },
      game_id: game.id
    })
  end
  # app/controllers/application_controller.rb

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
