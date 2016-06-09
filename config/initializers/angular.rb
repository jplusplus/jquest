# See https://github.com/pitr/angular-rails-template
Rails.application.config.angular_templates.module_name = 'jquest.template'

Rails.application.config.ng_annotate.ignore_paths = [
  Rails.root.join('vendor/').to_s
]
