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


  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end

  def self.unassigned_to(user, season=user.member_of)
    where(season: season).where.not(user: user)
  end
end
