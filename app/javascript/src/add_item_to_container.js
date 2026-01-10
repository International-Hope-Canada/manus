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

