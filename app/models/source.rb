class Source < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  
  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end
end
