class SeasonController < ApplicationController
  before_filter :can!
  rescue_from Pundit::NotAuthorizedError, with: :deny_access

  def index
    render './index'
  end

  def can!
    # A season module must be found
    raise Pundit::NotAuthorizedError.new "You don't have the permission to see this." unless season
  end

  # Current controller engine
  def engine
    self.class.to_s.split("::").first
  end

  # Current season
  def season
    @season ||= policy_scope(Season).find_by_engine(engine)
  end

  protected
    def deny_access(e)
      redirect_to '/', :alert => e.message
    end
end
