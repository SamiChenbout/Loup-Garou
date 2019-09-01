class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :players, dependent: :destroy
  has_many :messages, through: :players
  has_many :games, through: :players
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  mount_uploader :photo, PhotoUploader
end
