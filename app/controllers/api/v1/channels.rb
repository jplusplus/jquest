module API
  module V1
    class Channels < Grape::API
      resource :channels do
        desc "Return stats about connected users"
        get :status do
          # Return a hash
          {
            'total': slack_members.length,
            'active': slack_members.select { |u| u.presence == 'active' }.length,
            'hostname': slack_hostname
          }
        end
      end
    end
  end
end
