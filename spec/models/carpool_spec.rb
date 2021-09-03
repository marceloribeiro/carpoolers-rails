# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Carpool, type: :model do
  let(:subject) { build(:carpool) }

  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chapter) }
    it { is_expected.to belong_to(:start_pickup_location) }
    it { is_expected.to belong_to(:end_pickup_location) }
    it { is_expected.to have_many(:pickup_locations) }
    it { is_expected.to have_many(:carpool_passengers) }
    it { is_expected.to have_one(:conversation) }
  end
end
