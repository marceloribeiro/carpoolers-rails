# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:subject) { build(:user) }

  context 'relations' do
    it { is_expected.to have_many(:carpools) }
    it { is_expected.to have_many(:carpool_passengers) }
  end
end
