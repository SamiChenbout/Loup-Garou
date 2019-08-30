class LoverCouple < ApplicationRecord
  belongs_to :game
  belongs_to :lover1, class_name: "Player", foreign_key: "lover1_id"
  belongs_to :lover2, class_name: "Player", foreign_key: "lover2_id"

  validates :lover1, presence: true
  validates :lover2, presence: true
end
