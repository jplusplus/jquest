module API
  module V1
    class Base < Grape::API
      prefix 'v1'
      rescue_from :all
      format :json
      formatter :json, Grape::Formatter::ActiveModelSerializers

      mount Activities
      mount Assignments
      mount Schools
      mount Seasons
      mount Users
    end
  end
end
