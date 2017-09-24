Rails.application.routes.draw do
  root 'cars#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  resources :reservations
  resources :roles
  resources :cars
end
