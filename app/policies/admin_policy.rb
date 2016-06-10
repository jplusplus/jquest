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
    create?
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def destroy_all?
    destroy?
  end

end
