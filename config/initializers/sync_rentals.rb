Account.connection do
  Account.each do |account|
    Rental.synchronize(scope: account)
  end
end
