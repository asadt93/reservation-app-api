module ReservationServices
  class External < BaseService
    include DefaultErrorContainer
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def save
      ActiveRecord::Base.transaction do
        reservation = Reservation.new(external_payload.build_attributes)
        unless reservation.save
          merge_errors(reservation.errors)
          raise InvalidReservation
        end
        ServiceResult.new data: reservation
      end
    rescue InvalidReservation
      ServiceResult.new errors: errors, message: error_message_simple
    end

    def external_payload
      if params[:reservation].present? && params[:reservation][:code].present?
        ReservationServices::Externals::PayloadFoo.new(params)
      elsif params[:reservation_code].present?
        ReservationServices::Externals::PayloadBoo.new(params)
      else
        raise NotImplementedPayload
      end
    end

    class InvalidReservation < StandardError; end
    class NotImplementedPayload < StandardError; end
  end
end