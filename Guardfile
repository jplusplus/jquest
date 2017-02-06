group :frontend do
  # Load the Rails application.
  require_relative 'config/environment'

  watched_directories = [ Dir.pwd ]
  # Analyse every engines
  Rails::Engine.subclasses.each do |engine|
    # Does the engine have specs? Does the specs describe a jQuest season?
    if engine.season?
      # Add the engine's gem to the watch directorys
      watched_directories << engine.config.root.to_s
    end
  end
  # Set the watch dirs
  directories watched_directories

  livereload_directives = Proc.new do
    rails_view_exts = %w(erb haml slim)

    watch(%r{public/(.*/[^.][^/]+\.(css|js|html))}) {|m| m[1] }
    watch(%r{app/assets/(.*/[^.][^/])(\.s[ac]ss)?}) { |m| "/assets/#{m[1]}.css" }
    watch(%r{app/assets/(.*/[^.][^/]+\.js)(\.coffee)?}) { |m| "/assets/#{m[1]}" }
    watch(%r{app/assets/.+\.(#{rails_view_exts * '|'})$}) { |m| "/assets/#{m[1]}" }
    # file needing a full reload of the page anyway
    watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{config/locales/.+\.yml})
  end

  guard 'livereload', &livereload_directives
end

group :backend do
  guard :rspec, cmd: 'bundle exec rspec' do
    watch('spec/spec_helper.rb') { "spec" }
    watch('config/routes.rb') { "spec/routing" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  end
end
