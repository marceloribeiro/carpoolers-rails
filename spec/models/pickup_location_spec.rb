# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PickupLocation, type: :model do
  let(:subject) { build(:pickup_location) }

  context 'relations' do
    it { is_expected.to belong_to(:carpool) }
  end
end
