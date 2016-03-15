class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def access_denied!(exception)
    redirect_to '/', :alert => exception.message
  end
end
