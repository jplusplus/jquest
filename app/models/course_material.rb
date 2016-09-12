class CourseMaterialRenderer < Redcarpet::Render::HTML
  def initialize(extensions = {})
    super extensions.merge(link_attributes: { target: "_blank" })
  end
end

class CourseMaterial < ActiveRecord::Base
  extend Enumerize
  # Add a filter method to the scope
  include Filterable

  enumerize :status, :in => [:draft, :published], :default => :draft
  serialize :state_params, JSON
  has_paper_trail :on => [:update]

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
    @markdown ||= Redcarpet::Markdown.new(CourseMaterialRenderer, autolink: true, tables: true)
  end

  # True if the course has been seen by a given user
  def seenBy?(user)
    # Low level caching
    Rails.cache.fetch("#{cache_key}/seen_by/#{user.id}", expires_in: 1.minutes) do
      user.activities.exists?(resource: self, taxonomy: 'seen')
    end
  end
end
