require 'date'

class Doc
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users

  field :label, :type => String, default: ""
  field :type, :type => String, default: ""
  field :domain, :type => String, default: ""
  field :content, :type => Hash, default: {}

  # custom setter
  def content=(value)
    if value.respond_to?(:to_s)
      self[:content] = JSON.parse(value)
    else
      self[:content] = value
    end
  end

  def name
    self.label
  end
end
