Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'sessions#new'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  resources :reservations
  resources :roles
  resources :cars
end
