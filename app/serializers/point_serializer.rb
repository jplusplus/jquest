class PointSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user_id, :season_id, :value, :position
  attribute :school_id do
    object.user.school_id
  end

  attribute :user_display_name do
    object.user.display_name
  end
end
