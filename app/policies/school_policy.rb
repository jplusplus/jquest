class SchoolPolicy  < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @school = model
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
    @current_user != @school and @current_user.role?('admin')
  end

  # Reading...

  def index?
    ['admin', 'teacher'].include? @current_user.role
  end

  def show?
    ['admin', 'teacher'].include? @current_user.role
  end

end
