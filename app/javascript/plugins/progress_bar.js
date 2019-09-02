function move() {
  if(document.getElementById('bar')) {
    var elem = document.getElementById("bar");
    var width = 18;
    var id = setInterval(frame, 50);
    function frame() {
      if (width >= 95) {
        clearInterval(id);
      } else {
        width++;
        elem.style.width = width + '%';
        elem.innerHTML = width  + 5 + '%';
      }
    }
  }
}

function move2() {
  if(document.getElementById('bar2')) {
    var elem = document.getElementById("bar2");
    var width = 20;
    var id = setInterval(frame, 50);
    function frame() {
      if (width >= 97) {
        clearInterval(id);
      } else {
        width++;
        elem.style.width = width + '%';
      }
    }
  }
}

export { move, move2 };
