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
        paginate
        get do
          garner.options(expires_in: 10.minutes) do
            paginate policy_scope(Point).
              # Only positive points
              where('value > ?', 0).
              # We allow filtering
              search(declared params).
              result.
              # Join resources
              eager_load(:user).
              # Order by position
              order(value: :desc).
              # Allow caching
              to_a
          end
        end
      end
    end
  end
end
