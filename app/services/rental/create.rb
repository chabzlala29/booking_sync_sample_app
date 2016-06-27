class Rental::Create
  include Rental::HashAttributes

  def initialize(account:, attr: {})
    @name = attr[:name]
    @headline = attr[:headline]
    @summary = attr[:summary]
    @description = attr[:description]
    @account = account
  end

  def call
    if token = @account.oauth_access_token
      api = BookingSync::API.new(token)
      resp = api.create_rental(hash_attr)
      create_record(resp)
    end
  end

  protected

  def create_record(resp)
    rental = @account.rentals.new
    rental.synced_id = resp.id
    rental.name = resp.name
    rental.synced_data = resp
    rental.save
    rental
  end
end
