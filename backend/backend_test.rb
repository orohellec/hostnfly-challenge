require 'json'

require_relative '../config/environment'

file_input = File.read(File.dirname(__FILE__) + '/data/input.json')
parsed_input = JSON.parse(file_input)

listings = parsed_input["listings"]
bookings = parsed_input["bookings"]
reservations = parsed_input["reservations"]

Booking.delete_all
Reservation.delete_all
Listing.delete_all

listings.each do |listing| 
  Listing.create!(
    id: listing["id"], 
    num_rooms: listing["num_rooms"]
  ) 
end
bookings.each do |booking| 
  Booking.create!(
    id: booking["id"],
    listing_id: booking["listing_id"], 
    start_date: booking["start_date"], 
    end_date: booking["end_date"]) 
end
reservations.each do |reservation| 
  Reservation.create!(
    id: reservation["id"], 
    listing_id: reservation["listing_id"], 
    start_date: reservation["start_date"], 
    end_date: reservation["end_date"]
  ) 
end


