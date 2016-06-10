class ActivityPolicy  < AdminPolicy

  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def create?
    @user and (@model.user == @user or @user.role? :teacher, :admin)
  end

end
