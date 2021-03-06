module API
  module AuthenticableHelpers
    include Pundit

    delegate :session, to: :request
    
    def warden
      env['warden']
    end

    def current_user
      @current_user ||= warden.user
    end

    def season
      @season ||= current_user.member_of
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def permitted_params(object, params)
      parameters = ActionController::Parameters.new(params)
      parameters.permit( *policy(object).permitted_attributes )
    end

    def devise_mapping
      @devise_mapping ||= env['devise.mapping']
    end

    include ::Devise::Controllers::SignInOut
  end
end
