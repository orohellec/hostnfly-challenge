class GenerateMissionsService
  def generate
    create_first_checking_missions
    create_last_checkout_missions
    create_checkout_checkin_missions # must be call AFTER create_last_checkout_missions
  end

  def calcul_checking_price(num_rooms, price_per_room)
    i = 1
    total = 0
    while i <= num_rooms
      i += 1
      total += price_per_room
    end
    total
  end

  def create_first_checking_missions
    Booking.all.each do |booking|
      first_checking_price = calcul_checking_price(booking.listing.num_rooms, 10)
      Mission.create!(
        listing_id: booking.listing.id,
        mission_type: "first_checking",
        date: booking.start_date,
        price: first_checking_price
      )
    end
  end

  def create_last_checkout_missions
    Booking.all.each do |booking|
      last_checkout_price = calcul_checking_price(booking.listing.num_rooms, 5)
      Mission.create!(
        listing_id: booking.listing.id,
        mission_type: "last_checkout",
        date: booking.end_date,
        price: last_checkout_price
      )
    end
  end

  def create_checkout_checkin_missions
    Reservation.all.each do |reservation|
      last_checkout_missions = reservation.listing.last_checkout_missions
      last_checkout_missions_dates = last_checkout_missions.map { |mission| mission.date }

      if !last_checkout_missions_dates.include?(reservation.end_date)
        checkout_checkin_price = calcul_checking_price(reservation.listing.num_rooms, 10)
        Mission.create!(
          listing_id: reservation.listing.id,
          mission_type: "checkout_checkin",
          date: reservation.end_date,
          price: checkout_checkin_price
        )
      end
    end
  end
end