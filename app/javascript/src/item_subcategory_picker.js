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

  let classificationPickers = document.querySelectorAll('.classification-picker a')
  classificationPickers.forEach((picker) => {
    picker.addEventListener('click', (event) => {
      let showManualType = picker.dataset.classification == 'equipment'

      let manualType = document.querySelector('.manual-type')
      if (showManualType) {
        manualType.classList.remove('not-needed')
      } else {
        manualType.classList.add('not-needed')
      }
      manualType.querySelectorAll('select').forEach((input) => {
        input.disabled = !showManualType
      })
    })
  })
})