# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :cinema_halls, only: %(index show update create destroy)
  default_url_options host: 'http://localhost:3000/'
end
