class Assignment < ActiveRecord::Base
  extend Enumerize
  # Concern to check expiration field
  # NOT IMPLEMENTED
  include Expirable
  include InSeason
  include Filterable

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
end
