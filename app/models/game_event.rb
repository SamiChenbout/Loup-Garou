class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :actor, :class_name => 'Player'
  belongs_to :target, :class_name => 'Player'

  validates :event_type, presence: true
  validates :game_id, presence: true
  validates :actor_id, presence: true
  validates :target_id, presence: true

end
