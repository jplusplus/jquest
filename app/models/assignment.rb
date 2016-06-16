class Assignment < ActiveRecord::Base
  # Concern to check expiration field
  include Expirable

  belongs_to :user
  belongs_to :season
  belongs_to :resource, polymorphic: true

  after_initialize :find_season

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end

  def find_season
    # If a season is not given explicitely..
    if self.season.nil? and not self.user.nil? and not self.user.member_of.nil?
      # ...we deduce it from the user's group
      self.season = user.member_of
    end
  end
end
