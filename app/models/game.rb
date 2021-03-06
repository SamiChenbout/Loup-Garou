class Game < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  has_many :players, dependent: :destroy
  has_many :game_events
  has_many :users, through: :players
  has_many :characters, through: :players
  has_many :messages, dependent: :destroy
  has_many :lover_couples

  private

  def set_defaults
    self.round_step = "show-role"
    self.round = 0
    self.step = "waiting"
  end
end
