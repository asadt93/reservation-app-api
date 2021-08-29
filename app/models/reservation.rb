class Reservation < ApplicationRecord
  belongs_to :guest
  accepts_nested_attributes_for :guest, allow_destroy: false, reject_if: :all_blank

  monetize :payout_price_cents
  monetize :security_price_cents
  monetize :total_price_cents

  validates_uniqueness_of :code
end
