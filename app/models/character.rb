class Character < ApplicationRecord
  VALID_NAMES = %w(loup sorciere chasseur voyante cupidon)

  has_many :players
  has_many :games, through: :players
  has_many :users, through: :players

  validates :name, presence: true
  validates_inclusion_of :name, :in => VALID_NAMES
  validates :name, presence:true, uniqueness: true
end
