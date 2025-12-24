class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :role, null: false

      t.timestamps
    end

    add_index :users, [:first_name, :last_name], unique: true
  end
end
