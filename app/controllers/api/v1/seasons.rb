module API
  module V1
    class Seasons < Grape::API
      resource :seasons do
        desc "Return list of seasons"
        get do
          seasons = []
          # Analyse every engines
          Rails::Engine.subclasses.each do |engine|
            # Does the engine have specs? Does the specs describe a jQuest season?
            if engine.season?
              seasons << {
                :name => engine.gemspec.name || engine.name,
                :root_path => engine.root_path
              }
            end
          end
          seasons
        end
      end
    end
  end
end
