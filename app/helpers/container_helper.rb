module ContainerHelper
  def container_items_for_printable(container)
    container.inventory_items.includes(item_subcategory: :item_category).order(classification: :desc, item_category: { name: :asc }, item_subcategory: { name: :asc }, barcode: :asc)
  end

  def summarized_container_items_for_printable(container)
    items = container_items_for_printable(container)
    items.group_by { |item| item.supply? ? :supply : item.item_category.name }.map do |category, items_in_category|
      [ category, items_in_category.count, items_in_category.sum(&:value) ]
    end
  end
end
