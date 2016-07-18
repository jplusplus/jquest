class CourseMaterialPolicy  < AdminPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  # Reading...

  def index?
    @user
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
      # Other user can only see published material
      else
        scope.published
      end
    end
  end
end
