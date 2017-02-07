source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails',  :git => 'https://github.com/rails/rails'
gem 'rails', '5.0.0'
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Web server built for concurrency
gem 'puma'
# Implements data migration
gem 'seed_migration'
# User authentication
gem 'devise'
gem 'devise-two-factor'
gem 'devise_invitable'
# Permissions helper
gem 'pundit'
# Batch record creation
gem 'activerecord-import'
# Build smart API
gem 'grape'
gem 'grape-active_model_serializers'
gem 'active_model_serializers', "~> 0.10.0"
gem 'api-pagination'
# Cache with memcached
gem 'dalli'
# Allow CORS
gem 'rack-cors', :require => 'rack/cors'
# Cache strategies for Ruby & Rake apps
gem "garner"
# Backend Interface
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'active_admin_theme'
gem 'active_admin_import' ,  :git => 'https://github.com/activeadmin-plugins/active_admin_import'
gem 'active_admin-sortable_tree'
# Rails 5 support for active admin
gem 'inherited_resources',  :git => 'https://github.com/activeadmin/inherited_resources'
# Advanced search
gem 'ransack'
# Specials fields
gem 'country_select'
gem 'enumerize'
# ActiveRecord versioning
gem 'paper_trail'
# Better assets support
gem 'sprockets', '3.6.3'
gem 'angular-rails-templates', "~> 1.0.2"
gem 'ngannotate-rails'
gem 'sass-css-importer'
gem "bower-rails", "~> 0.10.0"
# Email prerendering
gem 'premailer-rails'
gem 'nokogiri'
# Markdown parser
gem 'redcarpet'
# AWS
gem 'aws-sdk', '~> 2'
# Slack integration
gem 'slack-ruby-client', "~> 0.7.5"
# Custom engine
# Developpers may want to override this value locally. Please read:
# http://bundler.io/v1.2/man/bundle-config.1.html#LOCAL-GIT-REPOS
# For instance : bundle config local.jquest_pg  ../jquest-pg
gem 'jquest_pg',  :git => 'https://github.com/jplusplus/jquest-pg', branch: 'master'

group :development, :production do
  gem 'pg'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.13'
  # Better error display
  gem "better_errors"
  gem "binding_of_caller"
  # Assets livereload
  gem 'guard-livereload', '~> 2.5.2', require: false
  gem "rack-livereload"
  # Test framework
  gem 'rspec-rails', '~> 3.5'
  gem 'guard-rspec', require: false  
  gem 'factory_girl_rails', '~> 4.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.3.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Tool to generate diagram from models
  # You must install `graphviz` to use this gem. Then run: rake erd
  gem "rails-erd"
  gem 'meta_request'
  # Kill all the N+1 queries, as well as unnecessarily eager loaded relations
  gem "bullet"
  # Track memory usage and ActiveRecord instances
  gem "oink"
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
