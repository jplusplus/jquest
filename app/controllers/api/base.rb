require "garner/mixins/rack"

module API
  class Base < Grape::API
    helpers AuthenticableHelpers
    helpers SlackHelpers
    helpers Garner::Mixins::Rack

    before do
      unless current_user.nil?
        # Allow us to track change on model
        PaperTrail.whodunnit = current_user.id
      end
    end

    mount V1::Base
  end
end
