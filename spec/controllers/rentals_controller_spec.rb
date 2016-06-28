require 'rails_helper'

RSpec.describe RentalsController, type: :controller do
  describe 'with authenticated account' do
    let(:account){ create(:account, id: 1) }

    before do
      account.update oauth_access_token: test_access_token
      allow(controller).to receive(:current_account).and_return(account)
      allow(controller).to receive(:load_rentals_from_account).and_return(true)
    end

    describe 'GET index' do
      before do
        # stop sync on test mode
        allow(controller).to receive(:load_rentals_from_account).and_return(true)
      end

      it 'respond success' do
        get :index
        expect(response).to be_success
      end
    end

    describe 'GET new' do
      it 'respond success' do
        get :new
        expect(response).to be_success
      end
    end

    describe 'POST create' do
      before(:each) do
        stub_post('rentals', { body: { rentals: [{ id: '1234', name: 'Test Rental' }] }.to_json })
        post :create, rental: { name: 'Test Name' }
      end

      it 'should redirect' do
        expect(response).to be_redirect
      end

      it 'created record' do
        result = account.rentals.reload.last
        expect(result.name).to eq 'Test Rental'
      end
    end

    describe 'PUT update' do
      before do
        create(:rental, id: 2, synced_id: 2, name: 'Test Rental Name', account_id: 1)
      end

      it 'should redirect' do
        VCR.use_cassette('updates given rental by ID') do
          patch :update, id: 2, rental: { name: 'Updated Rental Name' }
          expect(response).to be_redirect
        end
      end

      it 'created record' do
        VCR.use_cassette('updates given rental by ID') do
          patch :update, id: 2, rental: { name: 'Test Rental Update' }
          expect(Rental.find(2).name).to eq 'Updated Rental name'
        end
      end
    end

    describe 'DELETE record' do
      before do
        create(:rental, id: 2, synced_id: 2, name: 'Test Rental Name', account_id: 1)
      end

      it 'should redirect' do
        VCR.use_cassette('deletes given rental by ID') do
          delete :destroy, id: 2
          expect(response).to be_redirect
        end
      end

      it 'delete a record' do
        VCR.use_cassette('deletes given rental by ID') do
          delete :destroy, id: 2
          expect(Rental.where(id: 4)).to be_empty
        end
      end
    end

    describe 'GET record' do
      before do
        create(:rental, id: 2, synced_id: 2, name: 'Test Rental Name', account_id: 1)
      end

      it 'should be success' do
        get :show, id: 2
        expect(response).to be_success
      end
    end
  end
end
