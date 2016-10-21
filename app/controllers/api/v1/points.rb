 module API
  module V1
    class Points < Grape::API
      resource :points do
        desc "Return list of points"
        params do
          optional :user_id_eq, type: Integer
          optional :season_id_eq, type: Integer
          optional :school_id_eq, type: Integer
        end
        paginate
        get do
          paginate policy_scope(Point).
            # Only positive points
            where('value > ?', 0).
            # We allow filtering
            search(declared params).
            result.
            # Order by position
            order(value: :desc)
        end
      end
    end
  end
end
