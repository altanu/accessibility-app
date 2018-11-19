class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist


  has_many :contacts
  has_many :reviews
  has_many :locations, through: :trips

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  # validates :phone_number, presence: true
end
