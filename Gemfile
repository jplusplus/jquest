source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.4'
# We use bootstrap as a gem to be able to customize it
gem 'bootstrap', '~> 4.0.0.alpha3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Web server built for concurrency
gem 'puma'
# User authentication
gem 'devise'
gem 'devise-two-factor'
# Permissions helper
gem 'pundit'
# Build smart AP
gem 'grape'
gem 'grape-active_model_serializers'
gem 'active_model_serializers', "~> 0.10.0"
# Backend Interface
gem 'activeadmin', '~> 1.0.0.pre2'
gem 'active_admin_theme'
gem "active_admin_import" , github: "activeadmin-plugins/active_admin_import"
# Specials fields
gem 'country_select'
gem 'enumerize'
# Rich text editor
# gem 'rich', github: 'kreativgebiet/rich'
# gem 'paperclip'
# ActiveRecord versioning
gem 'paper_trail'
# Better assets support
gem 'angular-rails-templates'
gem 'ngannotate-rails'
gem 'sass-css-importer'
gem "bower-rails", "~> 0.10.0"
# Email prerendering
gem 'premailer-rails'
gem 'nokogiri'
# This won't work if you didn't checkout the gem repository in the parent directory.
gem 'jquest_pg', path: '../jquest-pg'
# gem 'jquest_pg', github: 'jplusplus/jquest-pg'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Better error display
  gem "better_errors"
  gem "binding_of_caller"
  # Assets livereload
  gem 'guard-livereload', '~> 2.5', require: false
  gem "rack-livereload"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
