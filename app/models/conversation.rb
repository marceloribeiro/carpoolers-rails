# frozen_string_literal: true

class Conversation < ApplicationRecord
  belongs_to :carpool
  has_many :messages
end
