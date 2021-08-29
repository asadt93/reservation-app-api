FactoryBot.define do
  factory :guest, class: 'Guest' do
    first_name { 'foo' } 
    last_name { 'boo' } 
    phone { '08121312' } 
    email {'foo@mail.co'} 
    description { '-' }  
  end
end