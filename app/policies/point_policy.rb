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
      if not @user or @user.member_of.nil?
        scope.none
      # Admin user can see everything
      elsif @user.role? :admin
        scope.all
      # Other can only see user from the season there are member of
      else
        scope.where season: @user.member_of
      end
    end
  end
end
