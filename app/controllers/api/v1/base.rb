module API
  module V1
    class Base < Grape::API
      prefix 'v1'
      format :json

      mount Users
      mount Schools
      mount Seasons
    end
  end
end
