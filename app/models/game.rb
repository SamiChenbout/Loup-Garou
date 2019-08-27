class Game < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  has_one :lover_couple, through: :players
  has_many :players
  has_many :users, through: :players
  has_many :characters, through: :players
  has_many :messages, dependent: :destroy

  private

  def set_defaults
    self.is_day = false
    self.round = 1
    self.step = "waiting"
  end
end
