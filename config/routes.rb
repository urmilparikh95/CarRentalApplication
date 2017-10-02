Rails.application.routes.draw do
  root 'cars#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users
  resources :cars do
    resources :reservations
  end
  get 'reservation_history', to: 'users#reservation_history'
  namespace :admin do
    resources :users
    get 'customers', to: 'users#customers'
    resources :cars
    get 'cars/:id/edit_status', to: 'cars#edit_status', as: 'car_edit_status'
    patch 'cars/:id/update_status', to: 'cars#update_status', as: 'car_update_status'
    get 'cars/:id/reservation_history', to: 'cars#reservation_history', as: 'car_reservation_history'
    get 'users/:id/reservation_history', to: 'users#reservation_history', as: 'user_reservation_history'
    resources :reservations
  end
  namespace :super_admin do
    resources :users
  end
end
