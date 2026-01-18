class RenameContainerConsigneeColumns < ActiveRecord::Migration[8.1]
  def change
    [:name, :address, :city, :region, :country, :postal_code].each do |col|
      rename_column :containers, col, "consignee_#{col}"
    end
    rename_column :containers, :contact, :consignee_contact_name
    rename_column :containers, :phone, :consignee_contact_phone
    rename_column :containers, :email, :consignee_contact_email
  end
end
