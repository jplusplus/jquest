class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :user, :season, :resource, :resource_type,
             :expires_at, :created_at
end
