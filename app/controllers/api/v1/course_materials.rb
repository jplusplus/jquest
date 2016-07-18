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
      end
    end
  end
end
