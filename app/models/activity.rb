class Activity < ActiveRecord::Base
  # Concern to validate taxonomies
  include Taxonomiable
  include InSeason

  belongs_to :user
  belongs_to :season
  belongs_to :assignment
  belongs_to :resource, polymorphic: true

  validates :user, presence: true

  after_create :set_user_points
  after_destroy :set_user_points
  after_update :set_user_points

  def set_user_points
    # Saving the point instance will trigger a new computation
    user.points.find_or_create_by(season: season).save
  end

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end
end
