class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :location

  has_and_belongs_to_many :contacts
end
