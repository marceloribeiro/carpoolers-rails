# frozen_string_literal: true

FactoryBot.define do
  factory :carpool do
    user
    chapter
    start_location { '3010 W Grant Line Rd, Tracy, CA 95304' }
    end_location { 'Dublin/Pleasanton BART Station, Pleasanton, CA' }
    start_time { '10:00 AM' }
    end_time { '10:30 AM' }
    seats_available { 2 }
  end
end
