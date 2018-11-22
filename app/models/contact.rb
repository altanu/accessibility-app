class Contact < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :trips

  validates :first_name, presence: true
  validates :email, presence: true
end
