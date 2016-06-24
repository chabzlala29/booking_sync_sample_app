Rails.application.routes.draw do
  root 'authenticated#index'
  mount BookingSync::Engine => '/'
end
