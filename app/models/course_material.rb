class CourseMaterial < ActiveRecord::Base
  extend Enumerize
  # Add a filter method to the scope
  include Filterable
  enumerize :status, :in => [:draft, :published], :default => :draft
  serialize :state_params, JSON

  scope :draft, ->{ status :draft }
  scope :published, ->{ status :published }
  scope :status, -> (status) { where status: status }
  scope :state_name, -> (name) { where state_name: name }

  def body_html
    markdown.render body
  end

  # Create a markdown rendered (once by class instance)
  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end
end
