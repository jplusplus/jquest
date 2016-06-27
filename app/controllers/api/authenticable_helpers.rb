module API
  module AuthenticableHelpers
    include Pundit

    def warden
      env['warden']
    end

    def current_user
      @current_user ||= warden.user
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end

    def permitted_params(object, params)
      parameters = ActionController::Parameters.new(params)
      parameters.permit( *policy(object).permitted_attributes )
    end

  end
end
