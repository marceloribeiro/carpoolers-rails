# frozen_string_literal: true

class PickupLocation < ApplicationRecord
  belongs_to :carpool
  geocoded_by :location
  after_validation :geocode

  def increment_sorting_index!
    update_attributes(sorting_index: sorting_index + 1)
  end
end
