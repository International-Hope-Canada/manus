require 'application_system_test_case'

class InventoryItemTest < ApplicationSystemTestCase
  setup do
    login
  end

  test 'updating an inventory item' do

    initial_subcategory = ItemSubcategory.first
    new_subcategory = ItemSubcategory.second
    item = InventoryItem.create!(inventoried_by: User.first, barcode: '123456', item_subcategory: initial_subcategory)

    visit edit_inventory_item_path(item)
    choose new_subcategory.name
    click_on 'Update inventory item'
    assert_content 'Inventory item was successfully updated'

    item.reload
    assert_equal new_subcategory, item.item_subcategory
  end
end