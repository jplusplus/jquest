module Rails
  class Engine
    class << self
      def gemspec
        gemspec = nil
        Dir.glob(config.root.to_s + '/*.gemspec').each do |f|
          gemspec = Gem::Specification::load(f)
        end
        gemspec
      end

      def season?
        gemspec and gemspec.metadata['season']
      end

      def schedule_path
        config.root.to_s + '/config/schedule.rb'
      end

      def has_schedule?
        File.exist? schedule_path
      end

      def root_path(suffix='/')
        if gemspec and gemspec.metadata['root_path']
          path = suffix + gemspec.metadata['root_path']
          path = path + '/' if not path.end_with? '/'
          path
        elsif gemspec.name
          suffix + gemspec.name.downcase + '/'
        else
          suffix + name.downcase + '/'
        end
      end
    end
  end
end
