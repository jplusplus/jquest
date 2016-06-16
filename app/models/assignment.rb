class Assignment < ActiveRecord::Base
  # Concern to check expiration field
  include Expirable
  include InSeason

  belongs_to :user
  belongs_to :season
  belongs_to :resource, polymorphic: true

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end
end
