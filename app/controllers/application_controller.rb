class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  def access_denied!(exception)
    redirect_to '/', :alert => exception.message
  end

  def index
    render 'layouts/application', layout: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :otp_attempt
  end
end
