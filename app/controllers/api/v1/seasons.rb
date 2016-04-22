module API
  module V1
    class Seasons < Grape::API
      resource :seasons do
        desc "Return list of seasons"
        get do
          authenticate!
          policy_scope Season
        end
      end
    end
  end
end
