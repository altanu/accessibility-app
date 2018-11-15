class User < ApplicationRecord
  has_many :contacts
  has_many :reviews
  has_many :locations, through: :trips
end
