# app/controllers/api/api_controller.rb
module Api
  class ApiController < ActionController::API
    # Aqui você pode incluir módulos, interceptadores e métodos que são comuns para todos os seus controladores API
    before_action :verify_token

    private

    def verify_token
      provided_token = request.headers['Authorization']
      if provided_token.blank? || provided_token != ENV['API_TOKEN']
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
