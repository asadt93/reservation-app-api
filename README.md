# Reservation API to accept different payload formats

> Service object class to save reservation and guest with different payload formats

## Version

---

- Ruby 2.6.6
- Rails v5.2.6

---

## Setup Local

---

- Create db `rails db:create`
- Migrate Table `rails db:migrate`
- Run local server `rails s`

---

## Create reservation endpoint API

##### http://{base_url}/api/reservations

&nbsp;
Payload #1

```json
{
  "reservation_code": "YYY12345678",
  "start_date": "2021-04-14",
  "end_date": "2021-04-18",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "4200.00",
  "security_price": "500",
  "total_price": "4700.00"
}
```

Payload #2

```json
{
  "reservation": {
    "code": "XXX12345678",
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": ["639123456789", "639123456789"],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4300.00"
  }
}
```

## How to use the service with external payload

The reservation save process will be handled in the service object `ReservationServices::External`  
and accept `ActionController::Parameters` parameters:

```ruby
service = ReservationServices::External.new(params)
result = service.save
result.success? # true or false
result.errors # returns errors message if success? method is false

```

##### How to add new external palyload structure

###### 1. Add a new subclass of `ReservationServices::Externals::Main`class in

###### `app/services/reservation_services/externals/` to handle new payload,

###### this class will required to implement 3 method:

&nbsp;

```ruby

# app/services/reservation_services/externals/payload_boo.rb

module ReservationServices
  module Externals
    class PayloadBoo < ReservationServices::Externals::Main
      def build_attributes
        reservation_attributes.merge(
          guest_attributes: guest_attributes
        )
      end

      def reservation_attributes
       # adjust and handle new payload here to returns reservation attributes
      end

      def guest_attributes
        # adjust and handle new payload here to returns guest attributes
      end
    end
  end
end


```

###### 2. determine the subclass that we need in `app/services/reservation_services/external.rb`

```ruby
#/services/reservation_services/external.rb
........
    def external_payload
      if params[:reservation].present? && params[:reservation][:code].present?
        ReservationServices::Externals::PayloadFoo.new(params)
      elsif params[:reservation_code].present?
        ReservationServices::Externals::PayloadBoo.new(params)
      else
        raise NotImplementedPayload
      end
    end
```

&nbsp;

## Rspec Test

```zsh
bundle exec rspec -f d

Api::ReservationsController
  GET #post
    create with payload boo
      response 201 success
      JSON body response contains expected recipe attributes
    create with payload foo
      response 201 success
      JSON body response contains expected recipe attributes

ReservationServices::External
  save
    with invalid params
      raise error
    with valid params boo
      success? is true
    with valid params foo
      success? is true
    with valid duplicate reservation code
      success? is false and return error code already taken

Finished in 0.31072 seconds (files took 0.64249 seconds to load)
8 examples, 0 failures

```
