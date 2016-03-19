class AdminPolicy  < ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    ['admin', 'teacher'].include? user.role
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def import?
    index?
  end

  def new?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  def destroy_all?
    index?
  end

end
