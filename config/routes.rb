# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, param: :user_id, only: %i[create edit destroy]
  resources :profiles, only: %i[show edit update]
end
