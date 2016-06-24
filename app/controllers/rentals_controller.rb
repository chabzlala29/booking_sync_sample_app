class RentalsController < ApplicationController
  before_filter :authenticate_account!

  before_action :get_rental, only: [:show]

  def index
    # Can be moved to a button synchronized or a CRON job but for now I'll just do it here :)
    Rental.synchronize(scope: current_account)
    @rentals = Rental.search(params[:q])
  end

  protected

  def get_rental
    @rental = Rental.find(params[:id])
  end
end
