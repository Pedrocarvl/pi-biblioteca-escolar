class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_usuario!

  layout :select_layout

  include Pagy::Backend

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :tipo])
  end

  def select_layout
    if devise_controller?
      action_name == "edit" || action_name == "update" ? "application" : "devise"
    else
      "application"
    end
  end
end
