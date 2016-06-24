class Rental < ActiveRecord::Base
  synced local_attributes: { name: :name }

  belongs_to :account

  CURRENT_LOCALE = 'en'

  delegate :name, :summary, :headline, :description, :reviews_count, to: :synced_data, allow_nil: true

  scope :by_name, -> (query) { where("name LIKE ?", "%#{query}%")  }

  def published_at
    synced_data.published_at.try(:to_datetime)
  end

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
