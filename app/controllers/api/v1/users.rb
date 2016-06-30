module API
  module V1
    class Users < Grape::API
      resource :users do
        desc "Return list of users"
        get do
          policy_scope(User).page(params[:page])
        end

        params do
          requires :id, type: Integer, desc: 'User id.'
        end
        route_param :id do
          desc 'Return a user using its id.'
          get do
            policy_scope(User).find(params[:id])
          end
        end
      end
    end
  end
end
