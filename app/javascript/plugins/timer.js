var timeLeft = 15;
const timerDiv = document.getElementById("countdown")
var timer = setInterval(function(){
  if (timerDiv)
    timerDiv.innerHTML = timeLeft;
    timeLeft -= 1;
    if(timeLeft <= 0){
      clearInterval(timer);
      timerDiv.innerHTML = "Finished"
    }
}, 1000);

export { timer }
