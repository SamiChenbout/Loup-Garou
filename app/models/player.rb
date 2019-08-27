class Player < ApplicationRecord
  belongs_to :user
  belongs_to :character
  belongs_to :game
  has_many :game_events

  # validates :user, presence: true, uniqueness: true

  after_initialize :set_defaults, unless: :persisted?

  private

  def set_defaults
    self.is_alive  = true
    self.points = 0
  end
end
