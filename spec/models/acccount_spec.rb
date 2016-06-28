require 'rails_helper'

RSpec.describe Account, :type => :model do
  describe 'associations' do
    it { should have_many :rentals }
  end
end
