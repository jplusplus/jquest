class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :email_md5, :role, :points, :school_id
  attribute :email, if: :is_current_user?

  def is_current_user?
    object == scope.current_user
  end

  # JSON Linked Data Identifier
  # see https://www.w3.org/TR/json-ld/#node-identifiers
  attribute :@id do
    # Base path using the request
    uri = URI.join scope.request.base_url, scope.request.fullpath,
      # Joined with the engine path and its resource
      "/api/v1/users/#{object.id}"
    # Convert URI instance to str
    uri.to_s
  end
end
