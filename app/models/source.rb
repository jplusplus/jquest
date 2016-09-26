include ActionView::Helpers::SanitizeHelper

class Source < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  before_validation :sanitize_value

  def self.resource_types
    ActiveRecord::Base.send(:subclasses).map(&:name)
  end

  def self.update_or_create(attrs)
    source = where(field: attrs.field, resource: attrs.resource).first_or_initialize
    source.update_attributes attrs.except(:id)
    source
  end

  protected

  def sanitize_value
    self.value = sanitize(self.value, :tags => %w(b i u strong a em))
  end
end
