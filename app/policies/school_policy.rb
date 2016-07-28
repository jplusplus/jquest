class SchoolPolicy  < AdminPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  # Writting...

  def create?
    @user and @user.role? :admin
  end

  def index?
    @user
  end

end
