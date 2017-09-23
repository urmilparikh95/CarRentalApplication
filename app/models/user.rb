class User < ApplicationRecord
  has_many :reservations
  has_many :cars, through: :reservations
  belongs_to :role
  validates :email, :first_name, :last_name, :role_id, presence: true
  validates :email, uniqueness: true
end
