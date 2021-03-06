# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.3'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << 'vendor/assets/bower_components'
Rails.application.config.assets.paths << 'app/assets/app'
Rails.application.config.assets.paths << 'app/assets/components'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += ['*.erb','*/*.erb']
Rails.application.config.assets.precompile += ['active_admin.css']
Rails.application.config.assets.precompile += ['app.css', 'app.js']
Rails.application.config.assets.precompile += ['mailer.css']
Rails.application.config.assets.precompile += ['rich/editor.css']
Rails.application.config.assets.precompile += %w(application.css application.js)
