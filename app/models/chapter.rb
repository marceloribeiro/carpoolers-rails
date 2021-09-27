# frozen_string_literal: true

class Chapter < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :carpools
  belongs_to :user

  geocoded_by :location
  before_validation :load_name
  after_validation :geocode

  def country
    'United States'
  end

  def load_name
    self.name ||= "#{city}, #{state}"
  end

  def location
    "#{city}, #{state}, #{country}"
  end
end
