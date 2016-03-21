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

      def root_path
        if gemspec and gemspec.metadata['root_path']
          gemspec.metadata['root_path']
        elsif gemspec.name
          gemspec.name.downcase
        else
          name.downcase
        end
      end
    end
  end
end
