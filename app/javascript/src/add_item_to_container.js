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

document.addEventListener('turbo:frame-load', setupAutosubmitBarcodeOnValid)
document.addEventListener('turbo:render', setupAutosubmitBarcodeOnValid)
document.addEventListener('DOMContentLoaded', setupAutosubmitBarcodeOnValid)

const reloadInventoryOnAddSuccess = (event) => {
  if (event.target.id != "add-item-to-container-scanner") {
    return
  }
  let successDiv = document.querySelector(".results-area-success")
  if (!successDiv) {
    return
  }
  let inventoryFrame = document.querySelector("turbo-frame#inventory_items_list")
  if (!inventoryFrame) {
    return
  }
  inventoryFrame.reload()
}

document.addEventListener('turbo:frame-load', reloadInventoryOnAddSuccess)
document.addEventListener('turbo:render', reloadInventoryOnAddSuccess)
document.addEventListener('DOMContentLoaded', reloadInventoryOnAddSuccess)

