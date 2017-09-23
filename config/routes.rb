Rails.application.routes.draw do
  root 'cars#index'
  get 'signup' => 'users#new'
  resources :users
  resources :reservations
  resources :roles
  resources :cars
end
