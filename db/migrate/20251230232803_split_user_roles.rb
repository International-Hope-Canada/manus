class SplitUserRoles < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :packer, :boolean, default: false, null: false
    add_column :users, :picker, :boolean, default: false, null: false

    User.where(role: 0).update_all(admin: true)
    User.where(role: 1).update_all(packer: true)
    User.where(role: 2).update_all(picker: true)
  end
end
