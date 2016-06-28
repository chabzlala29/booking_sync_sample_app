require 'rails_helper'

RSpec.describe Rental, :type => :model do
  describe 'associations' do
    it { should belong_to :account }
  end

  describe 'instance methods' do
    describe '#published_at' do
      let!(:rental){ create(:rental, synced_data: { published_at: '2016-06-23 08:19:08 UTC' }) }

      it 'set to datetime' do
        expect(rental.published_at).not_to be_nil
      end
    end
  end

  describe 'class methods' do
    describe '.search' do
      before do
        3.times { create(:rental) }
        @rental = create(:rental, name: 'Test Query')
      end

      it 'result by name' do
        results = Rental.search('Test Query')
        expect(results.count).to eq 1
        expect(results.first.name).to eq @rental.name
        expect(results.first.id).to eq @rental.id
      end

      it 'non case sensitive search' do
        results = Rental.search('test query')
        expect(results.count).to eq 1
        expect(results.first.name).to eq @rental.name
        expect(results.first.id).to eq @rental.id
      end

      it 'empty query' do
        results = Rental.search
        expect(results.count).to eq 4
      end
    end
  end
end
