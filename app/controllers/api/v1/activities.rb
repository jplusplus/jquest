module API
  module V1
    class Activities < Grape::API
      resource :activities do
        desc "Return the user activities"
        params do
          optional :season_id_eq, type: Integer
          optional :assignment_level_eq, type: Integer
        end
        get each_serializer: ActivitySerializer, include_resource: true  do
          authenticate!
          policy_scope(Activity).
            # We allow filtering
            search(declared params).
            result.
            # Join to related tables
            includes(:resource).
            where(user: current_user).
            # Sort by resource's id
            order(created_at: :desc).
            # Paginates
            page(params[:page]).
            # Default limit is 25
            per(params[:limit])
        end

        params do
          requires :id, type: Integer, desc: 'Activity id.'
        end
        route_param :id do
          get serializer: ActivitySerializer, include_resource: true do
            authenticate!
            # Retreive the course material
            policy_scope(Activity).find(params[:id])
          end
        end
      end
    end
  end
end
