class Location < ApplicationRecord
  has_many :trips
  has_many :reviews

  validates :house_number, presence: true
  validates :street, presence: true
end
