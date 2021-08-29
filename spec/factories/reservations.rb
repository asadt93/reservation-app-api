FactoryBot.define do
  factory :reservation, class: 'Reservation' do
    code { '1111'} 
    start_date { '2021-03-12' } 
    end_date {'2021-03-16' } 
    nights { '3'} 
    guests { '4' } 
    adults { '2' } 
    children { '1' } 
    infants { '1' } 
    status { 'accepted' } 
    payout_price_cents { 20000 } 
    security_price_cents { 20000 } 
    total_price_cents { 20000 }
    guest
  end
end