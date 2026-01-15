class AddInitialsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :initials, :string, limit: 3
    execute "UPDATE users SET initials = CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), 'X', UPPER(SUBSTRING(last_name, 1, 1)))"
    change_column_null :users, :initials, false
    add_index :users, :initials, unique: true
  end
end
