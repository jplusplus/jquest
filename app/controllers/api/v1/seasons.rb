module API
  module V1
    class Seasons < Grape::API
      resource :seasons do

        desc "Return list of seasons"
        get do
          policy_scope(Season)
        end

        params do
          requires :id, type: Integer, desc: 'Season id.'
        end
        route_param :id do

          desc 'Return a season using its id.'
          get do
            authenticate!
            # Find season
            policy_scope(Season).find(params[:id])
          end

          desc 'Add user activity to know we saw the intro'
          put :intro do
            authenticate!
            # Find season
            season = policy_scope(Season).find(params[:id])
            # And create an activity with the right taxonomy
            Activity.create user: current_user,
                            season: season,
                            taxonomy: 'intro'
          end
        end
      end
    end
  end
end
