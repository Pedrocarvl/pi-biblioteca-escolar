# app/controllers/api/api_controller.rb
module Api
  class ApiController < ActionController::API
    before_action :verify_token

    private

    def verify_token
      provided_token = request.headers['Authorization']
      if provided_token.blank? || provided_token != Rails.application.credentials.api_token
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
