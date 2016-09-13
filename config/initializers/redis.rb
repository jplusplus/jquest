if Rails.env.production?
  $redis = Redis.new url: ENV["REDIS_URL"]
  # Use Redis as cache store
  Rails.application.config.cache_store = :redis_store, ENV["REDIS_URL"], { expires_in: 90.minutes }
end
