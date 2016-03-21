class UserPolicy  < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  class Scope
    attr_reader :user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      case @current_user.role
        when 'teacher'
          scope.where(role: 'student')
        else
          scope.all
      end
    end
  end


  def create?
    ['teacher', 'admin'].include? @current_user.role
  end

  def import?
    create?
  end

  def index?
    create?
  end

  def show?
    create? or @current_user == @user
  end

  def update?
    create? or @current_user == @user
  end

  def destroy?
    @current_user != @user and @current_user.role?('admin')
  end

end
