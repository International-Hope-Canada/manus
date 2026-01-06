class ChangeExpiryDateToYear < ActiveRecord::Migration[8.1]
  def change
    remove_column :inventory_items, :oldest_expiry_date
    add_column :inventory_items, :oldest_expiry_year, :integer
  end
end
