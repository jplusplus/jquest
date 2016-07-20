Rails.application.config.after_initialize do
  Slack.configure do |config|
    config.token = ENV['SLACK_API_TOKEN']
  end
end
