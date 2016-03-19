module API
  class Base < Grape::API
    helpers Pundit
    helpers do
      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end
    
    mount V1::Base
  end
end
