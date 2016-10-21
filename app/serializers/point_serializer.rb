class PointSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user_id, :user_display_name, :school_id, :season_id, :value, :position
end
