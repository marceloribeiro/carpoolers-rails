# frozen_string_literal: true

module Carpooler
  include ActiveSupport::Concern

  def request_to_join_carpool(carpool)
    return if joined_carpool?(carpool)

    # TODO: Add ability to pickup someone in the middle of the ride
    carpool.carpool_passengers.create!(
      user: self,
      status: CarpoolPassenger.statuses[:requested],
      pickup_location: carpool.start_pickup_location,
      dropoff_location: carpool.end_pickup_location
    )
  end

  def passenger_for(carpool)
    carpool.carpool_passengers.where(user: self).first
  end

  def joined_carpool?(carpool)
    passenger_for(carpool).present?
  end

  def approved_for_carpool?(carpool)
    passenger_for(carpool).try(:approved?)
  end
end
