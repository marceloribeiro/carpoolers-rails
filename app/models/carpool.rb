# frozen_string_literal: true

class Carpool < ApplicationRecord
  enum frequency: %i[once daily weekly monthly]
  enum weekday: %i[sunday monday tuesday wednesday thursday friday saturday]

  belongs_to :user
  belongs_to :chapter
  has_many :pickup_locations
  has_many :carpool_passengers
  belongs_to :start_pickup_location, class_name: 'PickupLocation'
  belongs_to :end_pickup_location, class_name: 'PickupLocation'

  validates :start_location, :end_location, :start_time, :end_time,
            :seats_available, presence: true

  attr_accessor :start_location, :end_location, :start_time, :end_time

  before_validation :load_initial_data

  scope :latest, -> { order(created_at: :desc) }

  def load_initial_data
    load_initial_locations
    self.start_location ||= start_pickup_location.location
    self.end_location   ||= end_pickup_location.location
    self.start_time     ||= start_pickup_location.pickup_time
    self.end_time       ||= start_pickup_location.dropoff_time
  end

  def load_initial_locations
    self.start_pickup_location = PickupLocation.new(
      location: start_location,
      pickup_time: start_time
    )
    self.end_pickup_location = PickupLocation.new(
      location: end_location,
      dropoff_time: end_time
    )
    self.pickup_locations = [
      start_pickup_location,
      end_pickup_location
    ]
  end

  def remaining_seats
    seats_available - carpool_passengers.approved.count
  end

  def stops_count
    pickup_locations.count - 2
  end

  def pickup_at
    start_pickup_location.pickup_time.strftime('%H:%M %p')
  end

  def dropoff_at
    end_pickup_location.dropoff_time.strftime('%H:%M %p')
  end

  def status_for_carpooler(user)
    carpool_passengers.where(user: user).first.status
  end
end
