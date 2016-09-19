Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # Dispatch an error when Cloud Front trying to CDNify a forbidden resource
  match '*path', via: :all, to: 'errors#not_found',
    constraints: CloudfrontConstraint.new
  # Bind devise routes to controllers
  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  # Bind active admin routes to controllers
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
