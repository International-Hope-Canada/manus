// Avoid multiple plays or plays when navigating away. See https://github.com/hotwired/turbo-rails/issues/147

const removeAutoload = (event) => {
  let videos = document.querySelectorAll('audio[autoplay]');
  for(let i = 0; i < videos.length; i++) {
    videos[i].autoplay = false;
  }
}
document.addEventListener('turbo:before-render', removeAutoload);
document.addEventListener('turbo:before-frame-render', removeAutoload);
