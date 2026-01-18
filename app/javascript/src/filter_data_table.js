const setupFilters = () => {
  document.querySelectorAll('.filter-toggle').forEach((el) => {
    el.addEventListener('click', toggleFilterControls)
  })
}

const toggleFilterControls = (event) => {
  let parent = event.target.closest('.filter-control')
  
  document.querySelectorAll('.filter-control-open').forEach((openControl) => {
    if (openControl != parent) {
      openControl.classList.toggle('filter-control-open')
    }
  })

  if (parent.classList.toggle('filter-control-open')) {
    parent.querySelector("input:not([type='hidden']), select")?.focus()
  }

}

document.addEventListener('turbo:frame-load', setupFilters)
document.addEventListener('turbo:render', setupFilters)
document.addEventListener('DOMContentLoaded', setupFilters)
