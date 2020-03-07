class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :home_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def home_controller?
    params[:controller] == 'home'
  end
end
