function move() {
  var elem = document.getElementById("bar");
  var width = 10;
  var id = setInterval(frame, 50);
  function frame() {
    if (elem)
      if (width >= 95) {
        clearInterval(id);
      } else {
        width++;
        elem.style.width = width + '%';
        elem.innerHTML = width  + 5 + '%';
      }
  }
}

export {move};
