module API
  module V1
    class Base < Grape::API
      prefix 'v1'
      format :json

      mount Users
    end
  end
end
