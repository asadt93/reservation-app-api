module ReservationServices
  module Externals
    class PayloadBoo < ReservationServices::Externals::Main
      def build_attributes
        reservation_attributes.merge(
          guest_attributes: guest_attributes
        )
      end

      def reservation_attributes
        {
          code: params[:reservation_code], 
          start_date: params[:start_date], 
          end_date: params[:end_date], 
          nights: params[:nights], 
          guests: params[:guests], 
          adults: params[:adults], 
          children: params[:children], 
          infants: params[:infants], 
          status: params[:status], 
          payout_price:  Money.new(params[:payout_price], params['currency']), 
          security_price:  Money.new(params[:security_price], params['currency']), 
          total_price:  Money.new(params[:total_price], params['currency']), 
        }
      end

      def guest_attributes
        guest_params = params[:guest] || {}
        {
          first_name: guest_params[:first_name], 
          last_name: guest_params[:last_name], 
          phone: guest_params[:phone], 
          email: guest_params[:email], 
          description: guest_params[:description]
        }
      end
    end
  end
end
