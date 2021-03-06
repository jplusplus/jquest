class Season < ActiveRecord::Base
  extend Enumerize
  enumerize :status, in: [ :open, :close, :draft ], default: :draft
  validates :engine_name, presence: true

  has_many :users, through: :groups
  has_many :activities
  has_many :assignments
  has_many :groups

  def path
    engine_info[:root_path] if engine
  end

  def engine_info
    if engine
      {
        :root_path => engine.root_path,
        :name => engine.name
      }
    end
  end

  def engine
    @engine ||= begin
      if index = Season::engines_name.index { |e| e == engine_name }
        Season::engines()[index]
      end
    end
  end

  def controller
    @controller ||= Object.const_get(engine_name)::ApplicationController
  end

  def assign_to!(user)
    if controller.method_defined? :new_assignments!
      controller.new.new_assignments! user
    end
  end

  def self.engines
    engines = []
    # Analyse every engines
    Rails::Engine.subclasses.each do |engine|
      # Does the engine have specs? Does the specs describe a jQuest season?
      if engine.season?
        # Add JQuest's
        engines << engine
      end
    end
    engines
  end

  def self.engines_name
    self.engines.map { |n| n.to_s.split("::").first }
  end

  def self.ids
    # Low level caching
    Rails.cache.fetch("season/ids", expires_in: 5.minutes) do
      all.pluck(:id)
    end
  end
end
