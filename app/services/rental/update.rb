class Rental::Update
  def initialize(account:, id:, attr: {})
    @name = attr[:name]
    @headline = attr[:headline]
    @summary = attr[:summary]
    @description = attr[:description]
    @account = account
    @id = id
  end

  def call
    if token = @account.oauth_access_token
      api = BookingSync::API.new(token)
      resp = api.edit_rental(@id, hash_attr)
      update_record(resp)
    end
  rescue
    puts 'Something bad happened'
  end

  protected

  def update_record(resp)
    rental = @account.rentals.find_by(synced_id: resp.id)
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