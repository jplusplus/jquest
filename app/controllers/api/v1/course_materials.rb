module API
  module V1
    class CourseMaterials < Grape::API
      resource :course_materials do
        desc "Return course material"
        get do
          authenticate!
          policy_scope(CourseMaterial).
            # Sort by position
            order(:position).
            # We allow filtering by status from params
            filter(params.slice(:state_name)).
            # Paginates
            page(params[:page]).
            # Default limit is 25
            per(params[:limit])
        end

        params do
          requires :id, type: Integer, desc: 'Course Material id.'
        end
        route_param :id do
          get serializer: CourseMaterialSerializer, include_body: true do
            authenticate!
            # Retreive the course material
            policy_scope(CourseMaterial).find(params[:id])
          end

          desc 'Add user activity to know we saw this course material'
          put :seen do
            authenticate!
            # Retreive the course material
            course_material = policy_scope(CourseMaterial).find(params[:id])
            # And create an activity with the right taxonomy
            Activity.find_or_create_by! user: current_user,
                                        resource: course_material,
                                        taxonomy: 'seen'
          end
        end
      end
    end
  end
end
