class AddInventoryItemStatus < ActiveRecord::Migration[8.1]
  def change
    add_column :inventory_items, :status, :integer, null: false, default: 0
  end
end
