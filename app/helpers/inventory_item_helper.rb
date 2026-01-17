module InventoryItemHelper
  def apply_inventory_item_sorts_and_filters(inventory_items, context: nil)
    inventory_items = inventory_items.includes(item_subcategory: :item_category)
    case params[:inventory_item_sort]
    when "barcode"
      inventory_items.order(:barcode)
    when "category"
      inventory_items.order("item_category.name", "item_subcategory.name", created_at: :desc)
    when "status"
      inventory_items.order(:status, created_at: :desc)
    when "packed_by"
      inventory_items.left_joins(:inventoried_by).order(inventoried_by: { initials: :asc }, created_at: :desc)
    when "picked_at"
      inventory_items.order(Arel.sql("picked_at DESC NULLS LAST"), created_at: :desc)
    when "picked_by"
      inventory_items.left_joins(:picked_by).order(picked_by: { initials: :asc }, created_at: :desc)
    when "oldest_expiry_year"
      inventory_items.order(Arel.sql("oldest_expiry_year NULLS LAST"), created_at: :desc)
    when "container"
      inventory_items.order(Arel.sql("container_id DESC NULLS LAST"), created_at: :desc)
    when nil
      if context == :picking
        inventory_items.order(Arel.sql("picked_at DESC NULLS LAST"), created_at: :desc)
      else
        inventory_items.order(created_at: :desc)
      end
    else
      raise "Unexpected sort #{params[:inventory_item_sort]}"
    end
  end

  def grouped_item_category_options
    [ :equipment, :supply ].map do |classification|
      [ classification.to_s.humanize, ItemCategory.where(classification:).order(:name).map { |category| [ category.name, category.id ] } ]
    end
  end
end
