class Assignment < ActiveRecord::Base
  extend Enumerize
  # External concerns
  include InSeason
  # Add a filter method to the scope
  include Filterable
  # Concern to check expiration field
  # NOT IMPLEMENTED
  include Expirable

  belongs_to :user
  belongs_to :season
  belongs_to :resource, polymorphic: true
  has_many :activity, :dependent => :delete_all

  enumerize :status, :in => [:pending, :done, :rejected], :default => :pending

  scope :done, ->{ status :done }
  scope :pending, ->{ status :pending }
  scope :status, -> (status) { where status: status }

  before_create :set_level

  def set_level
    if not user.nil? and level.blank?
      # Get point instance for this season
      point = user.points.find_by season: season
      # Use the point level
      self.level = point.nil? ? 1 : point.level
    end
  end

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end

  def self.unassigned_to(user, season=user.member_of)
    where(season: season).where.not(user: user)
  end
end
