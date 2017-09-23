class User < ApplicationRecord
  has_many :reservations
  has_many :cars, through: :reservations
  belongs_to :role
end
