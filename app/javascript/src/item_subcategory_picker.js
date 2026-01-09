const initializeSubcategoryPicker = () => {
  let itemCategorySelect = document.querySelector('#item_subcategory_picker select[name="item_category_id"]')
  if (itemCategorySelect) {
    itemCategorySelect.addEventListener('change', onCategoryChange)
  }

  let classificationPickers = document.querySelectorAll('.classification-picker a')
  classificationPickers.forEach((picker) => {
    picker.addEventListener('click', onClassificationClick)

  })
}

const onClassificationClick = (event) => {
  let picker = event.target
  let showManualType = picker.dataset.classification == 'equipment'

  let manualType = document.querySelector('.manual-type')
  if (showManualType) {
    manualType.classList.remove('not-needed')
  } else {
    manualType.classList.add('not-needed')
  }
  manualType.querySelectorAll('input').forEach((input) => {
    input.disabled = !showManualType
    if (input.value == 'no_manual') {
      input.checked = true
    }
  })
}

const onCategoryChange = () => {
  let frame = document.getElementById('item_subcategory_picker')
  let url = URL.parse(frame.src)
  let itemCategorySelect = document.querySelector('#item_subcategory_picker select[name="item_category_id"]')
  url.searchParams.set(itemCategorySelect.name, itemCategorySelect.value)
  frame.src = url.toString()
}

document.addEventListener('turbo:frame-load', initializeSubcategoryPicker)
document.addEventListener('turbo:render', initializeSubcategoryPicker)

// Because classification affects the manual type dropdown, which is outside of the frame, we need to ensure that this logic runs on load as well.
document.addEventListener('turbo:frame-load', () => {
  let activeClassification = document.querySelector(".classification-picker a.active")
  if (activeClassification) {
    onClassificationClick({ target: activeClassification })
  }
})
