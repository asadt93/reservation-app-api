class Api::BaseController < ActionController::API
  def render_error(resource, status)
    render json: resource, adapter: :json_api,
          serializer: ActiveModel::Serializer::ErrorSerializer
  end
end