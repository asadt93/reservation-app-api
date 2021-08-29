class Api::ReservationsController < Api::BaseController
  before_action :set_reservation, only: [:show, :update, :destroy]

  # POST /reservations
  def create
    service = ReservationServices::External.new(params)
    result = service.save
    if result.success?
      render json: result.data, include: 'guest', status: :created
    else
      render_error(result, :unprocessable_entity)
    end
  end
end
