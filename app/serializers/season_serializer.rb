class SeasonSerializer < ActiveModel::Serializer
  attributes  :id, :name, :primary_color, :status,
              :created_at, :updated_at, :engine, :activities
  def engine
    object.engine_info
  end

  def activities
    current_user ||= scope.current_user
    if current_user
      Activity.where(user: current_user, season: object).order('created_at DESC')
    end
  end
end
