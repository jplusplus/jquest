module API
  module V1
    class Seasons < Grape::API
      resource :seasons do

        desc "Return list of seasons"
        get do
          policy_scope Season
        end

        params do
          requires :id, type: Integer, desc: 'Season id.'
        end
        route_param :id do

          desc 'Return a page using its id.'
          get do
            authenticate!
            policy_scope(Season).find(params[:id])
          end

          desc 'Add user activity to know we saw the intro'
          get :intro do
            authenticate!
            # And create an activity with the right taxonomy
            Activity.create! user: @current_user, season_id: params[:id], taxonomy: 'INTRO'
          end

        end
      end
    end
  end
end
