class AssignmentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user, :season, :resource, :resource_type, :status,
             :expires_at, :created_at
  # Use associated resources' serializers
  has_one :resource
  has_one :season
  # JSON Linked Data Identifier
  # see https://www.w3.org/TR/json-ld/#node-identifiers
  attribute :@id do
    # Base path using the request
    uri = URI.join scope.request.base_url, scope.request.fullpath,
      # Joined with the engine path and its resource
      "/api/v1/assignments/#{object.id}"
    # Convert URI instance to str
    uri.to_s
  end
end
