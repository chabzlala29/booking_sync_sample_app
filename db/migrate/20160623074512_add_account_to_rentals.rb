class AddAccountToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :account_id, :integer
    add_index :rentals, :account_id
  end
end
