class SeasonSerializer < ActiveModel::Serializer
  attributes  :id, :name, :primary_color, :status,
              :created_at, :updated_at, :engine, :activities, :progression
  def engine
    object.engine_info
  end

  def activities
    current_user ||= scope.current_user
    if current_user
      Activity.where(user: current_user, season: object).order('created_at DESC')
    end
  end

  def progression
    current_user ||= scope.current_user
    if current_user
      # Get current season controller (implemented by its engine)
      controller = object.controller
      # Returns the user's progression
      controller.new.progression(current_user, object).to_h
    end
  end
end
