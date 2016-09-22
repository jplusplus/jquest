ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'yaml'
# Find the env file
env_file = File.join(Dir.pwd, 'config', 'local-env.yml')
# Does the env file exists?
 if File.exists?(env_file)
  # Load the file
  YAML.load(File.open(env_file)).each do |key, value|
    # Take each key of the file to fill ENV
    ENV[key.to_s] = value
  end
end
