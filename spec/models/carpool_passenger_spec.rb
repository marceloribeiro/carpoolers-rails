# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarpoolPassenger, type: :model do
  let(:subject) { build(:carpool_passenger) }

  context 'relations' do
    it { is_expected.to belong_to(:carpool) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:pickup_location) }
    it { is_expected.to belong_to(:dropoff_location) }
  end
end
