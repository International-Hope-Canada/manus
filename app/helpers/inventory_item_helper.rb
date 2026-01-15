module InventoryItemHelper
  def apply_inventory_item_sorts_and_filters(inventory_items, context: nil)
    inventory_items = inventory_items.includes(item_subcategory: :item_category)
    case params[:inventory_item_sort]
    when "barcode"
      inventory_items.order(:barcode)
    when "category"
      inventory_items.order("item_category.name", "item_subcategory.name")
    when "status"
      inventory_items.order(:status)
    when "picked_at"
      inventory_items.order(picked_at: :desc, created_at: :desc)
    when "picked_by"
      inventory_items.left_joins(:picked_by).order(picked_by: { last_name: :asc, first_name: :asc})
    when nil
      if context == :picking
        inventory_items.order(picked_at: :desc)
      else
        inventory_items.order(created_at: :desc)
      end
    end
  end

  def grouped_item_category_options
    [ :equipment, :supply ].map do |classification|
      [ classification.to_s.humanize, ItemCategory.where(classification:).order(:name).map { |category| [ category.name, category.id ] } ]
    end
  end
end
