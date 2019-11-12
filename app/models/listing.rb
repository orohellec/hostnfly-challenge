class Listing < ApplicationRecord
  has_many :bookings
  has_many :reservations
  has_many :missions

  def last_checkout_missions
    Mission.where(
      listing_id: self.id,
      mission_type: "last_checkout"
    )
  end

end
