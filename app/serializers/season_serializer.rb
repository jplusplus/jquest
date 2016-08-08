class SeasonSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes  :id, :name, :primary_color, :status,
              :created_at, :updated_at, :engine, :activities, :progression

  # Use associated resources' serializers
  has_many :activities

  def engine
    object.engine_info
  end

  def progression
    current_user ||= scope.current_user
    if current_user
      # Get current season controller (implemented by its engine)
      controller = object.controller
      # Returns the user's progression
      controller.new.progression(current_user, object).to_h
    end
  end


  # JSON Linked Data Identifier
  # see https://www.w3.org/TR/json-ld/#node-identifiers
  attribute :@id do
    # Base path using the request
    uri = URI.join scope.request.base_url, scope.request.fullpath,
      # Joined with the engine path and its resource
      "/api/v1/seasons/#{object.id}"
    # Convert URI instance to str
    uri.to_s
  end
end
