module API
  module V1
    class Base < Grape::API
      prefix 'v1'
      # rescue_from :all

      format :json
      formatter :json, Grape::Formatter::ActiveModelSerializers

      mount API::V1::Activities
      mount API::V1::Assignments
      mount API::V1::Channels      
      mount API::V1::Countries
      mount API::V1::CourseMaterials
      mount API::V1::Schools
      mount API::V1::Seasons
      mount API::V1::Users
    end
  end
end
