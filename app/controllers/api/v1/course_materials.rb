module API
  module V1
    class CourseMaterials < Grape::API
      resource :course_materials do
        desc "Return course material"
        get do
          authenticate!
          policy_scope(CourseMaterial).
            # We allow filtering by status from params
            filter(params.slice(:state_name)).
            # Paginates
            page(params[:page])
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
        end
      end
    end
  end
end
