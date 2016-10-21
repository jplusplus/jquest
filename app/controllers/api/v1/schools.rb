module API
  module V1
    class Schools < Grape::API
      resource :schools do
        desc "Return list of schools"
        get do
          garner.options(expires_in: 5.minutes) do
            policy_scope(School).
              # Paginate
              page(params[:page]).
              # Default limit is 25
              per(params[:limit]).
              # To array to allow caching
              to_a
          end
        end
      end
    end
  end
end
