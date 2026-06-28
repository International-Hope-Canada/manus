require "application_system_test_case"

class InventoryItemTest < ApplicationSystemTestCase
  setup do
    login
  end

  test "updating an inventory item" do
    initial_subcategory = ItemSubcategory.first
    new_subcategory = ItemSubcategory.second
    item = InventoryItem.create!(inventoried_by: User.first, barcode: "123456", item_subcategory: initial_subcategory)

    visit edit_inventory_item_path(item)
    choose new_subcategory.name
    click_on "Update inventory item"
    assert_content "Inventory item was successfully updated"

    item.reload
    assert_equal new_subcategory, item.item_subcategory
  end

  test "creating an inventory item" do
    subcategory = item_subcategories(:floss)

    visit new_inventory_item_path
    fill_in "Barcode", with: "123456"
    click_link subcategory.classification.to_s.capitalize
    sleep 1
    select subcategory.item_category.name
    choose subcategory.name
    fill_in "Description", with: "So long dental plan"
    click_on "Add item to inventory"

    within "#inventory-review-area" do
      assert_content "123456 Dental: Floss Inventory"
    end

    item = InventoryItem.last
    assert_equal "123456", item.barcode
    assert_equal subcategory, item.item_subcategory

    # Description gets auto-filled unless the subcategory changes
    assert_field("Description", with: "So long dental plan")
    choose "Toothpaste"
    assert_field("Description", with: "")
  end
end
