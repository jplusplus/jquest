Rails.application.config.middleware.insert_before 0, "Rack::Cors" do
  # Allow CORS over root API and engines' API
  ( ['/', '/assets/*'] + Season.engines.map(&:root_path) ).each do |root_path|
    allow do
      origins '*'
      resource root_path + 'api/*', :headers => :any, :methods => [:get, :options]
    end
  end
end
