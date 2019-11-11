class Listing < ApplicationRecord
  has_many :bookings
  has_many :reservations
end
