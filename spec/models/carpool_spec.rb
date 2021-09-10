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

    it 'should return pickup time and dropoff time' do
      expect(subject.pickup_at).to eql('10:00 AM')
      expect(subject.dropoff_at).to eql('10:30 AM')
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

  context 'when dealing with passengers', vcr: true do
    let(:passenger_a) { build :user }
    let(:passenger_b) { build :user }

    before :each do
      subject.start_location  = '405 Madison Avenye, New York, NY 10017'
      subject.end_location    = '103 Orchard St, New York, NY 10002'
      subject.save
      subject.carpool_passengers.create!(
        user: passenger_a,
        initial_pickup_location: subject.start_pickup_location,
        final_pickup_location: subject.end_pickup_location,
        status: CarpoolPassenger.statuses[:approved]
      )
    end

    it 'should return available seats' do
      expect(subject.remaining_seats).to eql(1)
    end

    it 'should return if full' do
      subject.carpool_passengers.create!(
        user: passenger_b,
        initial_pickup_location: subject.start_pickup_location,
        final_pickup_location: subject.end_pickup_location,
        status: CarpoolPassenger.statuses[:approved]
      )
      expect(subject).to be_full
    end

    it 'should return the status for a single passenger' do
      expect(subject.status_for_carpooler(passenger_a))
        .to eql('approved')
    end
  end

  context 'when dealing with conversations', vcr: true do
    it 'should load a new conversation unless one exists' do
      expect(Conversation.count).to eql(0)
      subject.load_conversation
      expect(Conversation.count).to eql(1)
      expect(Conversation.last.carpool).to eql(subject)
      subject.load_conversation
      expect(Conversation.count).to eql(1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
