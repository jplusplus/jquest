module API
  class Base < Grape::API
    helpers Pundit
    helpers do
      def warden
        env['warden']
      end

      def current_user
        @current_user ||= warden.user
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    mount V1::Base
  end
end
