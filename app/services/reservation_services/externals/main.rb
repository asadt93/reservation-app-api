module ReservationServices
  module Externals
    class Main < ::BaseService
      attr_reader :params
      
      def initialize(params)
        @params = params.permit!
      end

      def build_attributes
        raise NotImplementedError
      end

      def reservation_attributes
        raise NotImplementedError
      end

      def guest_attributes
        raise NotImplementedError
      end
    end
  end
end