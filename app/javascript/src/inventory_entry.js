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

document.addEventListener('turbo:frame-load', preventFormSubmitOnEnter)
document.addEventListener('turbo:render', preventFormSubmitOnEnter)
document.addEventListener('DOMContentLoaded', preventFormSubmitOnEnter)