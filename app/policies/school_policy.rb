class SchoolPolicy  < ApplicationPolicy

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
    @user and @user.role? :teacher, :admin
  end

  # Reading...

  def index?
    @user and @user.role? :teacher, :admin
  end

  def show?
    @user and @user.role? :teacher, :admin
  end

end
