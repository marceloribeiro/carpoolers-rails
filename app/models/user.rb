# frozen_string_literal: true

class User < ApplicationRecord
  include Carpooler
  devise  :database_authenticatable, :registerable, :recoverable, :rememberable,
          :validatable # , :omniauthable

  has_many :carpools
  has_many :carpool_passengers

  def name
    "#{first_name} #{last_name}".strip
  end
end
