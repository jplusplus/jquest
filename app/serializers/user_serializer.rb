class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :email_md5, :role, :points, :school,
             :home_country, :firstname, :lastname

  attribute :email, if: :is_current_user?
  attribute :unconfirmed_email, if: :is_current_user?
  attribute :phone_number, if: :is_current_user?

  has_one :school

  def is_current_user?
    object == scope.current_user
  end

  attribute :home_country_name do
    object.home_country_data['name']
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
