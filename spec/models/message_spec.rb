# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:subject) { build(:message) }

  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:conversation) }
  end
end
