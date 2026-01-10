// Select all text in barcode field when it's focused. That way, if there's a value and it's scanned again, that old
// value will be overwritten.
//
// There is a message that comes up with a label that when clicked sets the focus, but if the user clicks directly in 
// the field, it won't happen.

const setupSelectOnFocus = () => {
  document.querySelectorAll(".barcode").forEach((input) => input.addEventListener('focus', selectOnFocus))
}

const selectOnFocus = (event) => event.target.select()

document.addEventListener('turbo:frame-load', setupSelectOnFocus)
document.addEventListener('turbo:render', setupSelectOnFocus)
document.addEventListener('DOMContentLoaded', setupSelectOnFocus)