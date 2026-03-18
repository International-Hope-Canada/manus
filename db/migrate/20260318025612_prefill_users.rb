class PrefillUsers < ActiveRecord::Migration[8.1]
  def up
    User.reset_column_information
    User.create!(first_name: 'Admin', last_name: 'User', initials: 'AXU', admin: true)
  end
end
