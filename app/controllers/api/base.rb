module API
  class Base < Grape::API
    helpers AuthenticableHelpers
    mount V1::Base
  end
end
