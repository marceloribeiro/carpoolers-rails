# frozen_string_literal: true

class CarpoolPassenger < ApplicationRecord
  enum status: %i[requested approved declined]

  belongs_to :carpool
  belongs_to :user
  belongs_to :initial_pickup_location, class_name: 'PickupLocation'
  belongs_to :final_pickup_location, class_name: 'PickupLocation'
end
