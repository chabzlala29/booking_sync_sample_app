class RentalsController < ApplicationController
  before_filter :authenticate_account!

  before_action :get_rental, only: [:show, :edit, :update, :destroy]

  def index
    load_rentals_from_account
    @rentals = current_account.rentals.search(params[:q]).
      paginate(page: params[:page])
  end

  def new
    @rental = current_account.rentals.new
  end

  def create
    redirect_with_exception do
      @rental = Rental::Create.new(account: current_account, attr: rental_params).call
      redirect_to @rental, { notice: 'Created Successfully' }
    end
  end

  def update
    redirect_with_exception do
      @rental = Rental::Update.new(account: current_account, id: @rental.synced_id, attr: rental_params).call
      redirect_to @rental, { notice: 'Updated Successfully' }
    end
  end

  def destroy
    redirect_with_exception do
      Rental::Delete.new(account: current_account, id: @rental.synced_id).call
      redirect_to root_path, { notice: 'Successfully deleted!' }
    end
  end

  protected

  def redirect_with_exception(&block)
    if block_given?
      begin
        yield
      rescue => e
        redirect_to @rental, { notice: e.message }
      end
    end
  end

  def get_rental
    @rental = current_account.rentals.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:name, :headline, :summary, :description)
  end

  def load_rentals_from_account
    # Can be moved to a button synchronized or a CRON job but for now I'll just do it here :)
    
    if params[:sync] || !current_account.rentals.any?
      Rental.synchronize(scope: current_account)
    end
  end
end
