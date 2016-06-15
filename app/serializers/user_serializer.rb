class UserSerializer < ActiveModel::Serializer
  has_one :school
  attributes :id, :email_md5, :role, :points, :school
  attribute :email, if: :is_current_user?

  def is_current_user?
    object == scope.current_user
  end

end
