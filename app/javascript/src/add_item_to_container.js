const setupAutosubmitBarcodeOnValid = () => {
  let barcodeInput = document.querySelector('#add-item-to-container-scanner #barcode')
  if (!barcodeInput) {
    return
  }
  barcodeInput.addEventListener('input', submitOnValid)
}

const submitOnValid = (event) => {
  if (event.target.checkValidity()) {
    event.target.closest('form').requestSubmit()
  }
}

document.addEventListener('turbo:render', setupAutosubmitBarcodeOnValid)
document.addEventListener('DOMContentLoaded', setupAutosubmitBarcodeOnValid)