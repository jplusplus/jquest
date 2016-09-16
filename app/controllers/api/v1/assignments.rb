module API
  module V1
    class Assignments < Grape::API
      resource :assignments do
        desc "Return the user assignments"
        params do
          optional :season_id_eq, type: Integer
          optional :status_eq, type: String
        end
        paginate
        get do
          authenticate!
          paginate policy_scope(Assignment).
            # We allow filtering
            search(declared params).
            result.
            where(user: current_user).
            # Sort by resource's id
            order(:resource_id).
            # We allow filtering by status from params
            filter params.slice(:status)
        end

        params do
          requires :id, type: Integer, desc: 'assignement id'
        end
        route_param :id do
          desc "Return a user assignment"
          get each_serializer: AssignmentSerializer, include_resource: true do
            authenticate!
            # Join to related tables
            current_user.assignments.includes(:resource).find(params[:id])
          end
        end
      end
    end
  end
end
