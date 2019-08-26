class Game < ApplicationRecord

  after_initialize :set_defaults, unless: :persisted?

  private

  def set_defaults
    self.is_day = false
    self.round = 1
  end
end
