module API
  module V1
    class Activities < Grape::API
      resource :activities do
        desc "Return the user activities"
        get do
          authenticate!
          policy_scope(Activity).where user: current_user
        end
      end
    end
  end
end
