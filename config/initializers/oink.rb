if defined? Oink
  Rails.application.middleware.use Oink::Middleware, logger: Rails.logger
end
