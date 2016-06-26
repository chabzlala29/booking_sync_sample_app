class RentalsController < ApplicationController
  before_filter :authenticate_account!

  before_action :get_rental, only: [:show, :edit, :update, :destroy]

  def index
    # Can be moved to a button synchronized or a CRON job but for now I'll just do it here :)
    Rental.synchronize(scope: current_account) if params[:sync]
    @rentals = current_account.rentals.search(params[:q]).
      paginate(page: params[:page])
  end

  def new
    @rental = current_account.rentals.new
  end

  def create
    @rental = Rental::Create.new(account: current_account, attr: rental_params).call
    redirect_to @rental
  end

  def update
    @rental = Rental::Update.new(account: current_account, id: @rental.synced_id, attr: rental_params).call
    redirect_to @rental
  end

  def destroy
    Rental::Delete.new(account: current_account, id: @rental.synced_id).call
    redirect_to :index, { notice: 'Successfully deleted!' }
  end

  protected

  def get_rental
    @rental = current_account.rentals.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:name, :headline, :summary, :description)
  end
end
