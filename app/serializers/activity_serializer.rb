class ActivitySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :resource_id, :user_id, :resource_type, :resource,
             :points, :taxonomy, :created_at


  def attributes(*args)
    if instance_options[:include_resource]
      super
    else
      super.except(:resource)
    end
  end

  has_one :resource, if: ->{ instance_options[:include_resource] }
  
  # JSON Linked Data Identifier
  # see https://www.w3.org/TR/json-ld/#node-identifiers
  attribute :@id do
    # Base path using the request
    uri = URI.join scope.request.base_url, scope.request.fullpath,
      # Joined with the engine path and its resource
      "/api/v1/activities/#{object.id}"
    # Convert URI instance to str
    uri.to_s
  end
end
