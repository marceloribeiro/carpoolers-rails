# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    sequence :email do |n|
      "johndoe#{n}@email.com"
    end
    password { 'change123' }
    password_confirmation { 'change123' }
  end
end
