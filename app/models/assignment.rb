class Assignment < ActiveRecord::Base
  extend Enumerize
  # Concern to check expiration field
  # NOT IMPLEMENTED
  include Expirable
  include InSeason

  belongs_to :user
  belongs_to :season
  belongs_to :resource, polymorphic: true
  has_many :activity, :dependent => :delete_all

  enumerize :status, :in => [:pending, :done, :rejected], :default => :pending

  scope :done, ->{ where(:status => :done) }
  scope :pending, ->{ where(:status => :pending) }

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end
end
