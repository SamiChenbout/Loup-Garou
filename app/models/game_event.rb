class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :actor, :class_name => 'User'
  belongs_to :target, :class_name => 'User'
end
