Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # devise_for :users, ActiveAdmin::Devise.config
  devise_for :users

  ActiveAdmin.routes(self)
  # You can have the root of your site routed with "root"
  root to: "application#index", via: [:get]

  # Activate API
  mount API::Base => '/api'

  # Analyse every engines
  Season::engines.each do |engine|
    # Add JQuest's engines route under /season/ endpoint
    mount engine => engine.root_path
  end


end
