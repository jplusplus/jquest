module API
  class Base < Grape::API
    helpers AuthenticableHelpers

    before do
      # Allow us to track change on model
      PaperTrail.whodunnit = current_user.id
    end

    mount V1::Base
  end
end
