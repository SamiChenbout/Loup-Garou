class Message < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :content, presence: true
  validates :player, presence: true
end
