# frozen_string_literal: true

FactoryBot.define do
  factory :chapter do
    user
    city { 'Mountain House' }
    state { 'CA' }
  end
end
