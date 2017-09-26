Rails.application.routes.draw do
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  root 'users#customer_home'
  get  'signup',  to: 'users#new'
  post 'signup',  to: 'users#create'
  get 'home' => 'users#customer_home'
  resources :users
  resources :cars do
    resources :reservations
  end
  namespace :admin do
    resources :users
    resources :reservations
    resources :cars
  end
  namespace :super_admin do
    resources :users
  end
end

