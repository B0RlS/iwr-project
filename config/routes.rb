# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :vacancy do
    patch '/publish', to: 'publish#update'
    resources :attributes, param: :attr_id, except: %i[show new]
    resources :country_search, only: %i[index]
  end

  namespace :user do
    get '/vacancies', to: 'vacancies#index'
  end

  resources :vacancies, param: :vac_id, except: %i[edit]
  resources :users, param: :user_id, except: %i[index new]
  resources :profiles, only: %i[show edit update]
end
