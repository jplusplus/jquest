class Season < ActiveRecord::Base
  enum statuses: { open: 'open', close: 'close', draft: 'draft' }

  def engine_info
    if index = Season::engines.index { |e| e.name == engine }
      {
        :root_path => Season::engines()[index].root_path,
        :name => Season::engines()[index].name
      }
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

end
