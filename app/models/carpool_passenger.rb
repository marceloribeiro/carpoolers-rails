# frozen_string_literal: true

class CarpoolPassenger < ApplicationRecord
  enum status: %i[requested approved declined]

  belongs_to :carpool
  belongs_to :user
  belongs_to :pickup_location
  belongs_to :pickup_location
  belongs_to :dropoff_location, class_name: 'PickupLocation'
end
