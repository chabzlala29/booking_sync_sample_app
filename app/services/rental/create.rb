class Rental::Create
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
  rescue
    puts 'Something bad happened'
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

  def hash_attr
    hash = {}
    hash[:name] = @name if @name
    hash[:headline_en] = @headline if @headline
    hash[:summary_en] = @summary if @summary
    hash[:description_en] = @description if @description
    hash
  end
end