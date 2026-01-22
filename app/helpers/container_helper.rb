module ContainerHelper
  def container_items_for_printable(container)
    container.inventory_items.includes(item_subcategory: :item_category).order(:classification, item_category: { name: :asc }, item_subcategory: { name: :asc }, barcode: :asc)
  end

  def summarized_container_items_for_printable(container)
    items = container_items_for_printable(container)
    items.group_by { |item| item.item_subcategory }.map do |subcategory, items_in_category|
      [ subcategory, items_in_category.count, items_in_category.sum(&:value) ]
    end
  end
end
