class Game < ApplicationRecord

  after_initialize :set_defaults, unless: :persisted?
  has_one :lover_couple, through: :players
  has_many :playersS

  private

  def set_defaults
    self.is_day = false
    self.round = 1
    self.step = "cupidon"
  end
end
