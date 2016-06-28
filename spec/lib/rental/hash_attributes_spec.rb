require 'rails_helper'

RSpec.describe Rentals::HashAttributes do
  class Dummy
    attr_accessor :name, :headline, :summary, :description

    include Rentals::HashAttributes
  end

  let(:dummy) do
    dummy = Dummy.new
    dummy.name = 'Test Name'
    dummy.headline = 'Test Headline'
    dummy.summary = 'Test Summary'
    dummy.description = 'Test Description'
    dummy
  end

  describe 'hash_attr' do
    it 'return hash' do
      hash = { name: dummy.name, headline_en: dummy.headline, summary_en: dummy.summary, description_en: dummy.description }
      expect(dummy.send(:hash_attr)).to eq hash
    end
  end
end
