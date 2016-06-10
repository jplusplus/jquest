class SeasonPolicy  < ApplicationPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  # Writting...

  def create?
    @user and @user.role? :admin
  end

  def import?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  # Reading...

  def index?
    @user and @user.role? :teacher, :admin
  end

  def show?
    index?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
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
      # Other user can only see season there are member of
      elsif @user.group
        # Must return a collection
        scope.where id: @user.group.season
      # Every user not member of any group can't see anything
      else
        scope.none
      end
    end
  end

end
