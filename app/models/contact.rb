class Contact < ApplicationRecord
  belongs_to :user
  has_many :trips, through: :companions
  has_many :companions

  validates :first_name, presence: true
  validates :email, presence: true

end
