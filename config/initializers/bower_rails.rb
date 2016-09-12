BowerRails.configure do |bower_rails|
  # Tell bower-rails what path should be considered as root. Defaults to Dir.pwd
  bower_rails.root_path = Rails.root.to_s

  # Invokes rake bower:install before precompilation. Defaults to false
  bower_rails.install_before_precompile = false

  # Invokes rake bower:resolve before precompilation. Defaults to false
  bower_rails.resolve_before_precompile = false

  # Invokes rake bower:install:deployment instead of rake bower:install. Defaults to false
  bower_rails.use_bower_install_deployment = false
end
