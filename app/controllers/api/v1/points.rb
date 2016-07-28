module API
  module V1
    class Points < Grape::API
      resource :points do
        desc "Return list of points"
        params do
          optional :user_id_eq, type: Integer
          optional :season_id_eq, type: Integer
          optional :user_school_id_eq, type: Integer
        end
        get do
          policy_scope(Point).        
            # Only positive points
            where('value > ?', 0).
            # We allow filtering
            search(declared params).
            result.
            # Join resources
            includes(:user).
            # Order by position
            order(value: :desc).
            # Paginate
            page(params[:page]).
            # Default limit is 25
            per(params[:limit])
        end
      end
    end
  end
end
