class CreateContainers < ActiveRecord::Migration[8.1]
  def change
    create_table :containers do |t|
      t.timestamps
      t.integer :application_number, null: false
      t.date :shipped_at
      t.string :name
      t.string :address
      t.string :country
      t.string :contact
      t.string :phone
      t.string :email
    end
  end
end
