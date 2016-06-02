watched_directories = [ Dir.pwd ]
# Analyse every engines
Rails::Engine.subclasses.each do |engine|
  # Does the engine have specs? Does the specs describe a jQuest season?
  if engine.season?
    watched_directories << engine.config.root.to_s
    # guard 'livereload' &livereload_directives
    # Add the engine's gem to the watch directorys
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
