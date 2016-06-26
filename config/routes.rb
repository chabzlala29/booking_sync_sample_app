Rails.application.routes.draw do
  root 'rentals#index'

  resources :rentals

  namespace :api do
    jsonapi_resources :rentals, only: [:index, :show]
  end

  mount BookingSync::Engine => '/'
end
