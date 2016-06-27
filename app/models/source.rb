class Source < ActiveRecord::Base
  belongs_to :resource, polymorphic: true

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end

  def self.update_or_create(attrs)
    source = where(field: attrs.field, resource: attrs.resource).first_or_initialize
    source.update_attributes attrs
    source
  end
end
