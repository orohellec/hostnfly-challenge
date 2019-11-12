require 'json'

require_relative '../config/environment'

file_input = File.read(File.dirname(__FILE__) + '/data/input.json')
parsed_input = JSON.parse(file_input)

listings = parsed_input["listings"]
bookings = parsed_input["bookings"]
reservations = parsed_input["reservations"]

Booking.delete_all
Reservation.delete_all
Mission.delete_all
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

GenerateMissionsService.new.generate

output = {
  missions: []
}

Mission.ordered_by_listing_id.each do |mission|
  output[:missions] << {
    listing_id: mission.listing.id,
    mission_type: mission.mission_type,
    date: mission.date,
    price: mission.price
  }
end

open('./backend/data/output.json', 'w') do |f|
  f << JSON.pretty_generate(output)
end


