module API
  module V1
    class Base < Grape::API
      prefix 'v1'
      format :json
      formatter :json, Grape::Formatter::ActiveModelSerializers

      mount Users
      mount Schools
      mount Seasons
    end
  end
end
