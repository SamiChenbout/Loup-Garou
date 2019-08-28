class Message < ApplicationRecord
  after_create :broadcast_message

  belongs_to :player
  belongs_to :game

  validates :content, presence: true

  private

  def broadcast_message
    ActionCable.server.broadcast("game_#{self.game.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/show",
        locals: { message: self } # user_is_messages_author: false
      ),
      current_user_id: self.player.user.id
    })
  end
end
