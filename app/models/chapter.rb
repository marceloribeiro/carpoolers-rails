# frozen_string_literal: true

class Chapter < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :carpools
  belongs_to :user
end
