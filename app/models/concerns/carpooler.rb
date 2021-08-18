# frozen_string_literal: true

module Carpooler
  include ActiveSupport::Concern

  def joined_carpool?(carpool)
    carpool.carpool_passengers.where(user: self).count.positive?
  end

  def request_to_join_carpool(carpool)
    return if joined_carpool?(carpool)

    # TODO: Add ability to pickup someone in the middle of the ride
    carpool.carpool_passengers.create!(
      user: self,
      status: CarpoolPassenger.statuses[:requested],
      initial_pickup_location: carpool.start_pickup_location,
      final_pickup_location: carpool.end_pickup_location
    )
  end
end
