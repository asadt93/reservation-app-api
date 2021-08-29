class ReservationSerializer < BaseSerializer
  attributes :id, :code, :start_date, :end_date, :nights, :guests, :adults, :children,
             :infants, :status
             
  belongs_to :guest
  
  attribute :payout_price do
    object.payout_price.amount.to_i
  end
  
  attribute :security_price do
    object.security_price.amount.to_i
  end
  
  attribute :total_price do
    object.total_price.amount.to_i
  end

  attribute :currency do
    object.payout_price_currency
  end
end