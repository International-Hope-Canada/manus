class CreateItemCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :item_categories do |t|
      t.string :name, null: false
      t.integer :classification, null: false
      t.decimal :value, precision: 10, scale: 2
      t.decimal :weight_kg, precision: 10, scale: 1

      t.timestamps
    end

    add_index :item_categories, [:name, :classification], unique: true
  end
end
