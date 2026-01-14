class CreateSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :settings do |t|
      t.string :setting_key, null: false, limit: 20
      t.string :setting_value, limit: 1000
    end
    add_index :settings, :setting_key, unique: true
  end
end
