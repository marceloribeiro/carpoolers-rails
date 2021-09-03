# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:subject) { build(:conversation) }

  context 'relations' do
    it { is_expected.to belong_to(:carpool) }
    it { is_expected.to have_many(:messages) }
  end
end
