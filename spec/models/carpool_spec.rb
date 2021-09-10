# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Carpool, type: :model do
  let(:subject) { build(:carpool) }

  context 'relations', vcr: true do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chapter) }
    it { is_expected.to have_many(:pickup_locations) }
    it { is_expected.to have_many(:carpool_passengers) }
    it { is_expected.to have_one(:conversation) }
  end

  context 'when storing pickup locations', vcr: true do
    before :each do
      subject.start_location  = '405 Madison Avenye, New York, NY 10017'
      subject.end_location    = '103 Orchard St, New York, NY 10002'
      subject.save
    end

    it 'should save the pickup locations' do
      expect(subject.pickup_locations.count).to eql(2)
      expect(subject.start_pickup_location.location)
        .to eql('405 Madison Avenye, New York, NY 10017')
      expect(subject.end_pickup_location.location)
        .to eql('103 Orchard St, New York, NY 10002')
    end

    it 'should return number of stops' do
      subject.add_stop(
        location: '125 E 11th St, New York, NY 10003',
        arrival_time: '10:15 AM',
        after: subject.start_pickup_location
      )

      expect(subject.stops_count).to eql(1)

      new_stop = subject.pickup_locations.order(id: :desc).first
      expect(new_stop.sorting_index).to eql(2)

      subject.reload
      expect(subject.pickup_locations.map(&:sorting_index).sort)
        .to eql([1, 2, 3])
    end
  end
end
# rubocop:enable Metrics/BlockLength
