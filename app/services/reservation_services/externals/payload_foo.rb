module ReservationServices
  module Externals
    class PayloadFoo < ReservationServices::Externals::Main
      def build_attributes
        reservation_attributes.merge(
          guest_attributes: guest_attributes
        )
      end

      def reservation_attributes
        {
          code: reservation_params[:code], 
          start_date: reservation_params[:start_date], 
          end_date: reservation_params[:end_date], 
          nights: reservation_params[:nights], 
          guests: reservation_params[:number_of_guests], 
          adults: guest_params[:number_of_adults], 
          children: guest_params[:number_of_children], 
          infants: guest_params[:number_of_infants], 
          status: reservation_params[:status_type], 
          payout_price:  Money.new(reservation_params[:expected_payout_amount], reservation_params[:host_currency]), 
          security_price:  Money.new(0, reservation_params[:host_currency]), 
          total_price:  Money.new(reservation_params[:total_paid_amount_accurate], reservation_params[:host_currency]), 
        }
      end

      def guest_attributes
        {
          first_name: reservation_params[:guest_first_name], 
          last_name: reservation_params[:guest_last_name], 
          phone: reservation_params[:guest_phone_numbers], 
          email: reservation_params[:guest_email], 
          description: guest_params[:localized_description]
        }
      end

      private

      def reservation_params
        params[:reservation] || {}
      end

      def guest_params
        reservation_params[:guest_details] || {}
      end
    end
  end
end
