class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter :set_csrf_cookie_for_ng
  # See https://github.com/airblade/paper_trail/blob/master/doc/warning_about_not_setting_whodunnit.md
  before_filter :set_paper_trail_whodunnit
  skip_after_action :warn_about_not_setting_whodunnit

  def index
    render './index'
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def access_denied!(exception)
    redirect_to '/', :alert => exception.message
  end

  def current_user
    @current_user ||= warden.user
  end

  # Disable yet
  def must_be_admin
    unless current_user.role? :admin, :teacher
      redirect_to '/', :alert => "You don't have the permission to see this."
    end
  end

  def after_sign_in_path_for(resource)
    path = super
    # Find the root path
    root_path = Rails.application.routes.url_helpers.root_path
    # Redirect to the group's season when the user try to reach the hompage
    # after she signed in.
    if path == root_path and resource.group and resource.group.season
      resource.group.season.path
    else
      path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: [:otp_attempt]
    devise_parameter_sanitizer.permit :account_update, keys: [
      :password, :password_confirmation, :current_password
    ]
    devise_parameter_sanitizer.permit :accept_invitation, keys: [
      :password, :password_confirmation, :current_password, :invitation_token
    ]
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

end
