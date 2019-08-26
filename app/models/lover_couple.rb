class LoverCouple < ApplicationRecord
  belongs_to :lover1, class_name: 'Player'
  belongs_to :lover2, class_name: 'Player'

  validates :lover1, presence: true
  validates :lover2, presence: true
end
