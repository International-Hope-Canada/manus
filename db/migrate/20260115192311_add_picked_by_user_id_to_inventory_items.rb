class AddPickedByUserIdToInventoryItems < ActiveRecord::Migration[8.1]
  def change
    add_column :inventory_items, :picked_by_id, :integer
    add_foreign_key :inventory_items, :users, column: :picked_by_id
    execute 'UPDATE inventory_items SET picked_by_id = (SELECT id from users order by id limit 1) WHERE container_id IS NOT NULL'
  end
end
