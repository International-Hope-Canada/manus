class AddPickedAtToInventoryItems < ActiveRecord::Migration[8.1]
  def change
    add_column :inventory_items, :picked_at, :datetime
    execute 'update inventory_items set picked_at = updated_at where container_id is not null'
  end
end
