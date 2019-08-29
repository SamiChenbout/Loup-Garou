class Message < ApplicationRecord
  after_create :broadcast_message, :broadcast_loup_message

  belongs_to :player
  belongs_to :game

  validates :content, presence: true

  private

  def broadcast_message
    ActionCable.server.broadcast("game_#{self.game.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/show",
        locals: { message: self }
      ),
      current_user_id: self.player.user.id
    })
  end

  def broadcast_loup_message
    if self.player.character.name == "loup" && player.is_alive
      ActionCable.server.broadcast("loup_messages_#{self.game.id}", {
        message_partial: ApplicationController.renderer.render(
          partial: "messages/show",
          locals: { message: self }
        ),
        current_user_id: self.player.user.id
      })
    end
  end
end
