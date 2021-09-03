# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chapter, type: :model do
  let(:subject) { build(:chapter) }

  context 'relations' do
    it { is_expected.to have_many(:carpools) }
  end
end
