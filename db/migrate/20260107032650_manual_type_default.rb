class ManualTypeDefault < ActiveRecord::Migration[8.1]
  def change
    change_column_default :inventory_items, :manual_type, 0
    execute 'UPDATE inventory_items SET manual_type = 0 where manual_type IS NULL'
    change_column_null :inventory_items, :manual_type, false
  end
end
