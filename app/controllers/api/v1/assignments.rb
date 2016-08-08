module API
  module V1
    class Assignments < Grape::API
      resource :assignments do
        desc "Return the user assignments"
        params do
          optional :season_id_eq, type: Integer
          optional :status_eq, type: String
        end
        get do
          authenticate!
          policy_scope(Assignment).
            # We allow filtering
            search(declared params).
            result.
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
