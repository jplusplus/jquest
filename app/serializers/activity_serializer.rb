class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :user, :season, :resource, :resource_type,
             :points, :taxonomy, :created_at
end
