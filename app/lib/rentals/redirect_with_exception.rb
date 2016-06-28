module Rentals
  module RedirectWithException
    protected

    def redirect_with_exception(&block)
      if block_given?
        begin
          yield
        rescue => e
          redirect_to @rental, { notice: e.message }
        end
      end
    end
  end
end
