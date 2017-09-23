Rails.application.routes.draw do
  resources :users
  resources :reservations
  resources :roles
  resources :cars
end
