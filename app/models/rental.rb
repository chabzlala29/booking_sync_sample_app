class Rental < ActiveRecord::Base
  synced local_attributes: { name: :name }

  belongs_to :account

  CURRENT_LOCALE = 'en'

  delegate :name, :summary, :headline, to: :synced_data, allow_nil: true

  scope :by_name, -> (query) { where("name LIKE ?", "%#{query}%")  }

  class << self
    def search(query='')
      if query.present?
        self.by_name(query)
      else
        self.all
      end
    end
  end
end
