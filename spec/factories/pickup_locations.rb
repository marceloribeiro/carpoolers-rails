# frozen_string_literal: true

FactoryBot.define do
  factory :pickup_location do
    carpool
    location { '3010 W Grant Line Rd, Tracy, CA 95304' }
  end
end
