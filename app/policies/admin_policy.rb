class AdminPolicy  < ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    is_admin?
  end

  def show?
    is_admin?
  end

  def create?
    is_admin?
  end

  def import?
    is_admin?
  end

  def new?
    is_admin?
  end

  def edit?
    is_admin?
  end

  def destroy?
    is_admin?
  end

  def destroy_all?
    is_admin?
  end

  protected

  def is_admin?
    user.role?(:admin)
  end

end
