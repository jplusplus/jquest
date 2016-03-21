module API
  module V1
    class Schools < Grape::API
      resource :schools do
        desc "Return list of schools"
        get do
          authenticate!
          policy_scope School
        end
      end
    end
  end
end
