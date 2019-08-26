class Game < ApplicationRecord
  def set_defaults
    self.is_day = false
    self.round = 1
  end
end
