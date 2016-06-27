class Rental::Delete
  def initialize(account:, id:)
    @account = account
    @id = id
  end

  def call
    if token = @account.oauth_access_token
      api = BookingSync::API.new(token)
      api.delete_rental(@id)
      @account.rentals.where(synced_id: @id).delete_all
    end
  end
end
