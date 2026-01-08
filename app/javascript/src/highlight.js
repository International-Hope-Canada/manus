const removeHighlight = () => {
  setTimeout(() => {
    document.querySelectorAll(".highlight").forEach((el) => el.classList.remove("highlight"))
  }, 3000)
}

document.addEventListener('turbo:frame-load', removeHighlight)
document.addEventListener('turbo:render', removeHighlight)
document.addEventListener('DOMContentLoaded', removeHighlight)
