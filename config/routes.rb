Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  get 'main/index'
  post 'users/enable_otp'
  post 'users/disable_otp'


  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # You can have the root of your site routed with "root"
  root to: "main#index", via: [:get, :post]

  # Activate API
  mount API::Base => '/api'

end
