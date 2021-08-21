# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: { message: 'or text content cannot be empty' }

  attr_accessor :carpool_id

  before_validation :load_conversation

  def load_conversation
    return if conversation.present?
    return if carpool_id.blank?
    self.conversation = Carpool.find(carpool_id).load_conversation
  end
end
