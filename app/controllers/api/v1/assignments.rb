module API
  module V1
    class Assignments < Grape::API
      resource :assignments do
        desc "Return the user assignments"
        get do
          authenticate!
          policy_scope(Assignment).where(user: current_user).page(params[:page])
        end
      end
    end
  end
end
