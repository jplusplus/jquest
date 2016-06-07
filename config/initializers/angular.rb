# See https://github.com/pitr/angular-rails-template
Rails.application.config.angular_templates.module_name = 'jquest.template'

Rails.application.configure do
  config.ng_annotate.paths = [ Rails.root.join('app/assets').to_s ]
  # Analyse every season's engines
  Season::engines.each do |engine|
    config.ng_annotate.paths << engine.config.root.to_s
    puts engine.config.root.join('app/assets').to_s
  end
end
