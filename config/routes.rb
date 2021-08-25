# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'movies#index'
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'override/registrations',
    sessions: 'override/sessions'
  }
  resources :cinema_halls, only: [:index, :show, :update, :create, :destroy]
  resources :movies, only: [:index, :show, :update, :create, :destroy]
  resources :reservations, only: [:index, :show, :update, :create]
end
