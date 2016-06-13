class ActivityPolicy  < AdminPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def create?
    @user and (@model.user == @user or @user.role? :teacher, :admin)
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
      # Teacher can only see their student activity
      elsif @user.role? :teacher
        scope.where season: @user.group.season
      # Others can only see their own activity
      else
        scope.where user: @user
      end
    end
  end
end
