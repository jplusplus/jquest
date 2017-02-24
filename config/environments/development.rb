Rails.application.configure do
  # Make javascript_pack_tag load assets from webpack-dev-server.
  config.x.webpacker[:dev_server_host] = "http://localhost:8080"

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
     'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end


  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.perform_deliveries = false
  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  config.log_level = :debug

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Avoid annotation angular apps
  config.ng_annotate.process = false
  # Suppress logger output for asset requests.
  config.assets.quiet = true
  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Eager loading  detections
  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_whitelist :type => :unused_eager_loading, :class_name => "User", :association => :group
  end

  # Use Memcachier
  if ENV.has_key?("MEMCACHIER_SERVERS")
    config.cache_store = :dalli_store,
                      (ENV["MEMCACHIER_SERVERS"] or "").split(","),
                      {:username => ENV["MEMCACHIER_USERNAME"],
                       :password => ENV["MEMCACHIER_PASSWORD"],
                       :failover => true,
                       :socket_timeout => 1.5,
                       :socket_failure_delay => 0.2,
                       :down_retry_delay => 60
                      }
  end
end
