# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Carpooler, type: :model do
  let(:subject) { build(:user) }
  let(:carpool) { build(:carpool) }

  context 'when requesting to join', vcr: true do
    before :each do
      subject.save
      carpool.save
    end

    it 'should join a carpool with the proper status' do
      expect { subject.request_to_join_carpool(carpool) }
        .to change(CarpoolPassenger, :count).by(1)
    end

    it 'should return true when joined' do
      subject.request_to_join_carpool(carpool)
      expect(subject.joined_carpool?(carpool)).to eql(true)
    end

    it 'should return true when approved' do
      subject.request_to_join_carpool(carpool)
      CarpoolPassenger.last.approved!
      expect(subject.approved_for_carpool?(carpool)).to eql(true)
    end
  end
end
