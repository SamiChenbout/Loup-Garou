class Player < ApplicationRecord
  belongs_to :user
  belongs_to :character
  belongs_to :game
end
