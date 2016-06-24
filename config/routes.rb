Rails.application.routes.draw do
  root 'rentals#index'

  resources :rentals, only: [:index, :show]

  namespace :api do
    jsonapi_resources :rentals, only: [:index, :show]
  end

  mount BookingSync::Engine => '/'
end
