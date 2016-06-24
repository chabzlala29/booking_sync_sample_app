class Api::RentalResource < JSONAPI::Resource
  attributes :name, :summary, :headline, :description
end
