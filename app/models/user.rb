class User < ApplicationRecord
  has_secure_password

  has_many :contacts
  has_many :reviews
  has_many :locations, through: :trips
  has_many :trips

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  # validates :phone_number, presence: true
end
