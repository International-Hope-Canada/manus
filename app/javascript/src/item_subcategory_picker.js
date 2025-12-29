document.addEventListener('turbo:frame-load', () => {
  let frame = document.getElementById('item_subcategory_picker')
  let url = URL.parse(frame.src)

  let itemCategorySelect = document.querySelector('#item_subcategory_picker select[name="item_category_id"]')
  if (itemCategorySelect) {
    itemCategorySelect.addEventListener('change', () => {
      url.searchParams.set(itemCategorySelect.name, itemCategorySelect.value)
      frame.src = url.toString()
    })
  }
})