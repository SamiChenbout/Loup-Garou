class Player < ApplicationRecord
  belongs_to :user
  belongs_to :character
  belongs_to :game

  has_many :messages, dependent: :destroy
  has_many :actor_game_events, class_name: "GameEvent", foreign_key: "actor_id",dependent: :destroy
  has_many :target_game_events, class_name: "GameEvent", foreign_key: "target_id",dependent: :destroy

  #has_many :lover1_players, class_name: "Player", foreign_key: "lover1_id", dependent: :destroy
 # has_many :lover2_players, class_name: "Player", foreign_key: "lover2_id", dependent: :destroy

  # validates :user, presence: true, uniqueness: true

  after_initialize :set_defaults, unless: :persisted?

  private

  def set_defaults
    self.is_alive = true
    self.is_link = false
    self.state_chasseur = ""
  end
end
