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

  def sortable_title
    if category
      "#{title}&nbsp;<em class='small'>#{category}</em>".html_safe
    else
      title
    end
  end

  # Create a markdown rendered (once by class instance)
  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

  # True if the course has been seen by a given user
  def seenBy?(user)
    user.activities.exists?(resource: self, taxonomy: 'seen')
  end
end
