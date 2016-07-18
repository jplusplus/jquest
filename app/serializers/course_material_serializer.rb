class CourseMaterialSerializer < ActiveModel::Serializer
  # Do build hypermedia link
  include Rails.application.routes.url_helpers

  attributes :id, :title, :state_name, :body_html, :category
  attribute :state_params do
    # Parse the state_params string
    JSON.parse object.state_params unless object.state_params.blank?
  end
  # JSON Linked Data Identifier
  # see https://www.w3.org/TR/json-ld/#node-identifiers
  attribute :@id do
    # Base path using the request
    uri = URI.join scope.request.base_url, scope.request.fullpath,
      # Joined with the engine path and its resource
      "/api/v1/course_materials/#{object.id}"
    # Convert URI instance to str
    uri.to_s
  end
end
