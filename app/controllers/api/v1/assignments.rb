module API
  module V1
    class Assignments < Grape::API
      resource :assignments do
        desc "Return the user assignments"
        get do
          authenticate!
          policy_scope(Assignment).
            # Join to related tables
            includes(:resource).
            where(user: current_user).
            # Sort by resource's id
            order(:resource_id).
            # We allow filtering by status from params
            filter(params.slice(:status)).
            # Paginates
            page(params[:page]).
            # Default limit is 25
            per(params[:limit])
        end
      end
    end
  end
end
