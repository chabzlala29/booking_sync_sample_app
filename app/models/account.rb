class Account < ActiveRecord::Base
  include BookingSync::Engine::Model

  has_many :rentals
end
