module API
  module V1
    class Countries < Grape::API
      formatter :json, Grape::Formatter::Json

      resource :countries do
        desc "Return all countries"
        params do
          optional :page, type: Integer, default: 1
          optional :limit, type: Integer, default: 25
        end
        get do
          garner.options(expires_in: 24.hours) do
            # Get all country
            countries = ISO3166::Country.codes.map do |code|
              ISO3166::Country.new(code).data
            end
            # Paginate result
            offset = (params[:page] - 1) * params[:limit]
            countries = countries.slice offset, params[:limit]
            # Return as json
            countries.as_json(only: ['name', 'alpha2', 'alpha3'])
          end
        end
      end
    end
  end
end
