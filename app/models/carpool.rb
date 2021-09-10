# frozen_string_literal: true

class Carpool < ApplicationRecord
  enum frequency: %i[once daily weekly monthly]
  enum weekday: %i[sunday monday tuesday wednesday thursday friday saturday]

  belongs_to :user
  belongs_to :chapter
  has_one :conversation
  has_many :pickup_locations
  has_many :carpool_passengers

  validates :start_location, :end_location, :start_time, :end_time,
            :seats_available, presence: true

  attr_accessor :start_location, :end_location, :start_time, :end_time

  before_validation :load_initial_locations

  scope :latest, -> { order(created_at: :desc) }

  def load_initial_locations
    self.pickup_locations = [
      PickupLocation.new(
        location: start_location,
        arrival_time: start_time,
        sorting_index: 1
      ),
      PickupLocation.new(
        location: end_location,
        arrival_time: end_time,
        sorting_index: 2
      )
    ]
  end

  def start_pickup_location
    @start_pickup_location ||=
      pickup_locations.order(sorting_index: :asc).first
  end

  def end_pickup_location
    @end_pickup_location ||=
      pickup_locations.order(sorting_index: :asc).last
  end

  def add_stop(options = {})
    prior_location = options.delete(:after) || start_pickup_location

    pickup_locations.where('sorting_index > ?', prior_location.sorting_index)
                    .each(&:increment_sorting_index!)

    options[:sorting_index] = prior_location.sorting_index + 1
    pickup_locations.create!(options)
  end

  def stops_count
    pickup_locations.count - 2
  end

  def pickup_at
    start_pickup_location.arrival_time.strftime('%H:%M %p')
  end

  def dropoff_at
    end_pickup_location.arrival_time.strftime('%H:%M %p')
  end

  def remaining_seats
    seats_available - carpool_passengers.approved.count
  end

  def full?
    !remaining_seats.positive?
  end

  def status_for_carpooler(user)
    carpool_passengers.where(user: user).first.status
  end

  def load_conversation
    return conversation if conversation.present?
    Conversation.create!(carpool: self)
  end
end
