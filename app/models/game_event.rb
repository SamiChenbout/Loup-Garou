class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :actor, :class_name => 'Player'
  belongs_to :target, :class_name => 'Player'

  validates :event_type, presence: true
  validates :game, presence: true
  validates :actor, presence: true
  validates :target, presence: true

end
