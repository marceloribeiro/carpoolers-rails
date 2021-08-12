class User < ApplicationRecord

  devise  :database_authenticatable, :registerable, :recoverable, :rememberable,
          :validatable# , :omniauthable

  has_many :carpools
  has_many :carpools_passengers

end
