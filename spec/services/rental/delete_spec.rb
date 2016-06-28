RSpec.describe Rental::Delete do
  describe 'deletes a record' do
    it 'deleted successfully' do
      VCR.use_cassette('deletes given rental by ID') do
        account = create(:account, oauth_access_token: test_access_token)
        rental = create(:rental, synced_id: 2, id: 2, account_id: account.id)
        Rental::Delete.new(account: account, id: rental.id).call
        expect(Rental.where(synced_id: rental.synced_id)).to be_empty
      end
    end
  end
end
