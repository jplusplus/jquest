Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # You can have the root of your site routed with "root"
  root to: "application#index", via: [:get]

  # Activate API
  mount API::Base => '/api'

  # Analyse every engines
  Rails::Engine.subclasses.each do |engine|
    # Does the engine have specs? Does the specs describe a jQuest season?
    if engine.season?
      # Build engine path
      path = "/season/#{engine.gemspec.metadata['root_path']}"
      # Add JQuest's engines route under /season/ endpoint
      mount engine => path
      puts "=> Routing #{engine.name} though #{path}"
    end
  end


end
