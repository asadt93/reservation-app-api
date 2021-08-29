class Guest < ApplicationRecord
  serialize :phone, JSON
  has_many :reservations
end
