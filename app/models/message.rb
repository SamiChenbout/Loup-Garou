class Message < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :content, presence: true
end
