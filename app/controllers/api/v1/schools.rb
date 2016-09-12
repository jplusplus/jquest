module API
  module V1
    class Schools < Grape::API
      resource :schools do
        desc "Return list of schools"
        get do
          authenticate!
          garner.options(expires_in: 5.minutes) do
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
end
