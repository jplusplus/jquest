# See https://github.com/pitr/angular-rails-template
Rails.application.config.angular_templates.module_name = 'jquest.template'

Rails.application.configure do
  # Add the root dir
  config.ng_annotate.paths = [ Rails.root.join('app/assets').to_s ]
  # Analyse every engines
  Rails::Engine.subclasses.each do |engine|
    # Does the engine have specs? Does the specs describe a jQuest season?
    if engine.season?
      config.ng_annotate.paths << engine.config.root.to_s
    end
  end
end
