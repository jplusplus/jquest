class Season < ActiveRecord::Base
  extend Enumerize
  enumerize :status, in: [ :open, :close, :draft ], default: :draft

  def engine_info
    if index = Season::engines_name.index { |e| e == engine }
      {
        :root_path => Season::engines()[index].root_path,
        :name => Season::engines()[index].name
      }
    end
  end

  def path
    engine_info[:root_path] if engine
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
end
