class BarcodeShorter < ActiveRecord::Migration[8.1]
  def change
    change_column :inventory_items, :barcode, :string, null: false, limit: 10
  end
end
