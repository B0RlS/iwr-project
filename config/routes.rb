Rails.application.routes.draw do

  root               'home#home'
  get '/signup', to: 'users#new'
  get '/login',  to: 'sessions#new'
  post '/login', to:  'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :profiles, except: [:index]
end