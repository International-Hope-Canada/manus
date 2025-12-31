class AddContainerIdToInventoryItems < ActiveRecord::Migration[8.1]
  def change
    add_column :inventory_items, :container_id, :integer
    add_foreign_key :inventory_items, :containers
  end
end
