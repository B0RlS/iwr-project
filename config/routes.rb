# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  get 'password_resets/new'
  get 'password_resets/edit'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resource :admin, param: :user_id, only: %i[show destroy update]
  resource :director, param: :user_id, only: %i[show update]

  get '/user/existence/:email', to: 'users#email_uniq?', constraints: { email: /.+\..+/}

  namespace :vacancy do
    resources :attributes, param: :attr_id, except: %i[show new]
    resources :country_search, only: %i[index]
    resources :requests, only: %i[index create update]
  end

  namespace :user do
    get '/vacancies', to: 'vacancies#index'
    resource :skill_level, only: %i[edit]
    resource :education, only: %i[edit update]
  end

  resource :manager, param: :user_id, only: %i[show]
  resources :vacancies, param: :vac_id, except: %i[edit]
  resources :users, param: :user_id, except: %i[index new show]
  resources :profiles, param: :user_id, only: %i[show edit update]
  resources :password_resets, only: %i[create edit update]
  resources :account_activations, only: %i[edit]
end
