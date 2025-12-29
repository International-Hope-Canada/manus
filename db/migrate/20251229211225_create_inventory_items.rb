class CreateInventoryItems < ActiveRecord::Migration[8.1]
  def change
    create_table :inventory_items do |t|
      t.timestamps
      t.string :barcode, null: false, limit: 50
      t.belongs_to :item_subcategory, null: false, foreign_key: true
      t.date :oldest_expiry_date, null: false
      t.text :description
      t.belongs_to :inventoried_by, null: false, foreign_key: { to_table: :users }
      t.integer :manual_type
    end
    add_index :inventory_items, :barcode, unique: true
  end
end
