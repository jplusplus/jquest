class PointPolicy  < AdminPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      # Anonymous users can't see anything
      if not @user
        scope.none
      # Admin user can see everything
      elsif @user.role? :admin
        scope.all
      # Teacher can only see their student points
      elsif @user.role? :teacher
        scope.where season: @user.group.season
      # Others can only see their own points
      else
        scope.where user: @user
      end
    end
  end
end
