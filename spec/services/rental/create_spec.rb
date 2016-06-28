RSpec.describe Rental::Create do
  describe 'create a record' do
    it 'should created successfully' do
      VCR.use_cassette('create a rental') do
        account = create(:account, oauth_access_token: test_access_token)
        result = Rental::Create.new(account: account, attr: { name: 'New rental'} ).call
        expect(result).not_to be_nil
        expect(Rental.find_by(result.synced_id)).not_to be_nil
      end
    end

    it 'provided with no account' do
      expect do
        Rental::Create.new(account: nil, attr: { name: 'New rental'} ).call
      end.to raise_error(NoMethodError)
    end
  end
end
