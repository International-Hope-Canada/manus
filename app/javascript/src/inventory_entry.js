// The scanner will send the barcode digits and then send an Enter. We don't want this to submit the form.
// We also want to prevent form submission if the focus is elsewhere and something is scanned, so disable
// enter-submits-form on all inputs on the new inventory page.
const preventFormSubmitOnEnter = () => {
  document.querySelectorAll('#inventory-entry-area input').forEach((input) => input.addEventListener('keydown', interceptEnter))
}

const interceptEnter = (event) => {
  if (event.key !== "Enter") {
    return
  }
  event.preventDefault()
  
  // If we were actually on the barcode field, send focus elsewhere to prevent double-scans from putting in
  // an invalid value.
  if (event.target.id === 'inventory_item_barcode') {
    document.querySelector("[data-classification='equipment']").focus()
  }
}

const onSubcategoryChange = (event) => {
  console.log('subcategory change')
  let description = document.querySelector('#inventory_item_description')
  if (description.dataset.autoFill === '1') {
    clearDescription()
  }
}

const initSubcategoryChangeListener = () => {
  document.querySelectorAll('.item-subcategory-picker input, .item-subcategory-picker select').forEach((radio) => radio.addEventListener('change', onSubcategoryChange))
  document.querySelectorAll('.classification-picker a').forEach((link) => link.addEventListener('click', onSubcategoryChange))
}

const onDescriptionChange = (event) => {
  let input = event.target
  if (input.dataset.autoFill === '1') {
    input.dataset.autoFill = null
  }
}

const initDescriptionChangeListener = () => {
  document.querySelector('#inventory_item_description')?.addEventListener('input', onDescriptionChange)
}

const clearDescription = (event) => {
  let description = document.getElementById('inventory_item_description')
  description.value = ''
  description.dataset.autoFill = null
  event?.preventDefault()
}

const initDescriptionClearListener = () => {
  document.querySelector('.description-clear')?.addEventListener('click', clearDescription)
}

const init = () => {
  preventFormSubmitOnEnter()
  initSubcategoryChangeListener()
  initDescriptionChangeListener()
  initDescriptionClearListener()
}

document.addEventListener('turbo:frame-load', init)
document.addEventListener('turbo:render', init)
document.addEventListener('DOMContentLoaded', init)