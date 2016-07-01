module API
  module V1
    class Assignments < Grape::API
      resource :assignments do
        desc "Return the user assignments"
        get do
          authenticate!
          policy_scope(Assignment).
            where(user: current_user).
            # We allow filtering by status from params
            filter(params.slice(:status)).
            # Paginates
            page(params[:page])
        end
      end
    end
  end
end
