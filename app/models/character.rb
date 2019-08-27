class Character < ApplicationRecord
  VALID_NAMES = %w(loup sorciere chasseur voyante cupidon)

  has_many :players, dependent: :destroy
  has_many :games, through: :players
  has_many :users, through: :players

  validates_inclusion_of :name, :in => VALID_NAMES
  validates :name, presence: true
end
