module Rentals
  module HashAttributes
    protected

    def hash_attr
      hash = {}
      hash[:name] = @name if @name
      hash[:headline_en] = @headline if @headline
      hash[:summary_en] = @summary if @summary
      hash[:description_en] = @description if @description
      hash
    end
  end
end
