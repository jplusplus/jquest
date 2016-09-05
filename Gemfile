source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.4'
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
gem 'devise_invitable'
# Permissions helper
gem 'pundit'
# Batch record creation
gem 'activerecord-import'
# Build smart API
gem 'grape'
gem 'grape-active_model_serializers'
gem 'active_model_serializers', "~> 0.10.0"
# Allow CORS
gem 'rack-cors', :require => 'rack/cors'
# Backend Interface
gem 'activeadmin', github: 'activeadmin'
gem 'active_admin_theme'
gem "active_admin_import" , github: "activeadmin-plugins/active_admin_import"
gem "active_admin-sortable_tree"
# Advanced search
gem 'ransack'
# Specials fields
gem 'country_select'
gem 'enumerize'
# ActiveRecord versioning
gem 'paper_trail'
# Better assets support
gem 'sprockets', '3.6.3'
gem 'angular-rails-templates', "~> 1.0.1"
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
gem 'jquest_pg', github: 'jplusplus/jquest-pg', branch: 'master'
# Scheduler
gem 'whenever', require: false
# Developpers may want to override this value locally. Please read:
# http://bundler.io/v1.2/man/bundle-config.1.html#LOCAL-GIT-REPOS

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
  # Tool to generate diagram from models
  # You must install `graphviz` to use this gem. Then run: rake erd
  gem "rails-erd"
  gem 'meta_request'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
