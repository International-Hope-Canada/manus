class AddCatchallToItemSubcategories < ActiveRecord::Migration[8.1]
  def change
    add_column :item_subcategories, :catchall, :boolean, default: false, null: false
    execute <<~SQL
      UPDATE item_subcategories
      SET catchall = TRUE
      WHERE name IN ('Other', 'Mixed', 'General')
    SQL
  end
end
