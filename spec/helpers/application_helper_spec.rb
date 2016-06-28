require 'rails_helper'

RSpec.describe ApplicationHelper do
  class Dummy
    extend ActionView::Helpers::DateHelper
    extend ApplicationHelper
  end

  describe 'published_since' do
    it 'translates datetime' do
      expect(Dummy.published_since(DateTime.now)).to eq 'published less than a minute ago'
    end

    it 'just accept datetime object' do
      expect(Dummy.published_since('Some String')).to eq nil
    end
  end
end
