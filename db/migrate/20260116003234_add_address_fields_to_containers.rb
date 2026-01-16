class AddAddressFieldsToContainers < ActiveRecord::Migration[8.1]
  def change
    add_column :containers, :city, :string
    add_column :containers, :region, :string
    add_column :containers, :postal_code, :string
  end
end
