module API
  module V1
    class Schools < Grape::API
      resource :schools do
        desc "Return list of schools"
        get do
          policy_scope(School).
            # Paginate
            page(params[:page]).
            # Default limit is 25
            per(params[:limit])
        end
      end
    end
  end
end
