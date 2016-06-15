module API
  module V1
    class Schools < Grape::API
      resource :schools do
        desc "Return list of schools"
        get do
          policy_scope(School).page(params[:page])
        end
      end
    end
  end
end
