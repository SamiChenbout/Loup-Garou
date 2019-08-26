class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :actor
  belongs_to :target
end
