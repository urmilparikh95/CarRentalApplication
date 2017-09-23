class Car < ApplicationRecord
  enum status: { available: 'available', reserved: 'reserved', checked_out: 'checked out' }

  has_many :reservations
  has_many :users, through: :reservations
end
