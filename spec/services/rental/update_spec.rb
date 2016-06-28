RSpec.describe Rental::Update do
  describe 'update a record' do
    let(:account){ create(:account, oauth_access_token: test_access_token) }
    let(:rental){ create(:rental, synced_id: 2, id: 2, account_id: account.id) }

    it 'updated successfully' do
      VCR.use_cassette('updates given rental by ID') do
        Rental::Update.new(account: account, id: rental.id, attr: { name: 'Updated Rental name' } ).call
        expect(Rental.find_by(synced_id: rental.synced_id).name).to eq 'Updated Rental name'
      end
    end

    it 'provided with no account' do
      expect do
        Rental::Update.new(account: nil, id: rental.id, attr: { name: 'Updated Rental name' } ).call
      end.to raise_error(NoMethodError)
    end
  end
end
