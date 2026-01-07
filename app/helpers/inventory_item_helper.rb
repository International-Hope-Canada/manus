module InventoryItemHelper
  def apply_inventory_item_sorts_and_filters(inventory_items)
    inventory_items = inventory_items.includes(item_subcategory: :item_category)
    case params[:inventory_item_sort]
    when 'barcode'
      inventory_items = inventory_items.order(:barcode)
    when 'category'
      inventory_items = inventory_items.order('item_category.name', 'item_subcategory.name')
    when 'status'
      inventory_items = inventory_items.order(:status)
    end

    inventory_items
  end
end