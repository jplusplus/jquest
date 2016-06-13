class Activity < ActiveRecord::Base
  # Concern to validate taxonomies
  include Taxonomiable

  belongs_to :user
  belongs_to :season
  belongs_to :resource, polymorphic: true


  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end
end
