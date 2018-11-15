class Contact < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :email, presence: true
end
