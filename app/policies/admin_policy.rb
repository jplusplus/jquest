class AdminPolicy  < ApplicationPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    @user and @user.role? :teacher, :admin
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
