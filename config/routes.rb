# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'movies#index'
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'override/registrations',
    sessions: 'override/sessions'
  }
  resources :cinema_halls, only: %i[index show update create destroy]
  resources :movies, only: %i[index show update create destroy]
  resources :reservations, only: %i[index show update] do
    collection do
      post '/online', to: 'reservations#create'
      post '/offline', to: 'reservations#create_offline'
    end
  end
end
