module API
  module V1
    class Seasons < Grape::API
      resource :seasons do
        desc "Return list of seasons"
        get do
          policy_scope Season
        end

        params do
          requires :token, type: String, desc: 'Page id or engine name.'
        end
        route_param :token do
          desc 'Return a page using its slug or its id.'
          get do
            authenticate!
            # Token isnt a positive integer
            if !/\A\d+\z/.match(params[:token])
              season = policy_scope(Season).find_by_engine(params[:token])
            else
              season = policy_scope(Season).find(params[:token].to_i)
            end

            season
          end
        end
      end
    end
  end
end
