require File.expand_path('../boot', __FILE__)

# require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jquest
  class Application < Rails::Application

    env_file = File.join(Rails.root, 'config', 'local-env.yml')
    YAML.load(File.open(env_file)).each do |key, value|
      ENV[key.to_s] = value
    end if File.exists?(env_file)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # You can set Mongoid configuration options in your application.rb along
    # with other Rails environment specific options by accessing config.mongoid.
    # Options set here will override those set in your config/mongoid.yml.
    config.mongoid.logger = Logger.new($stdout, :warn)

    # In order to properly set up single collection inheritance, Mongoid needs
    # to preload all models before every request in development mode.
    # This can get slow, so if you are not using any inheritance
    # it is recommended you turn this feature off.
    config.mongoid.preload_models = false

    config.generators do |g|
      g.orm :mongoid
    end
  end
end
