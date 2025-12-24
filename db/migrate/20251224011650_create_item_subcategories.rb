class CreateItemSubcategories < ActiveRecord::Migration[8.1]
  def change
    create_table :item_subcategories do |t|
      t.string :name, null: false
      t.belongs_to :item_category, null: false
      t.decimal :value, precision: 10, scale: 2
      t.decimal :weight_kg, precision: 10, scale: 1

      t.timestamps
    end

    add_foreign_key :item_subcategories, :item_categories
    add_index :item_subcategories, [:name, :item_category_id], unique: true
  end
end
