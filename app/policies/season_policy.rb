class SeasonPolicy  < ApplicationPolicy

  attr_reader :current_user, :season

  def initialize(current_user, season)
    @current_user = current_user
    @season = season
  end

  # Writting...

  def create?
    @current_user.role == 'admin'
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
    ['admin', 'teacher'].include? @current_user.role
  end

  def show?
    ['admin', 'teacher'].include? @current_user.role
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
      scope.all
    end
  end

end
