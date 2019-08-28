const firstNight = () => {
  if(document.querySelector('.firstNight')) {
    randomCouple();
  };
}

const randomCouple = () => {
  document.querySelector('.cupidon').classList.remove('d-none');
  setTimeout(function() {
    if (document.querySelector('.cupidon').hasClass("d-none") === false){
      $.ajax({
        type: "POST",
        url: "/games/<% @game.id %>/random_couple"
      });
    };
  }, 15000);
}

const otherNight = () => {
  if(document.querySelector('.night')) {
    setTimeout(function() {
      document.querySelector('.voyante').classList.remove('d-none');
    }, 20000);
    setTimeout(function() {
      document.querySelector('.voyante').classList.add('d-none');
      document.querySelector('.loup').classList.remove('d-none');
    }, 30000);
    endOfNight();
  };
}

const endOfNight = () => {
  document.querySelector('.endOfNight').innerHTML = "<% @game.update(is_day: true) %>";
}

const voyante = () => {
  if (document.querySelector('.voyante').classList.contains('d-none')) {
     //GO TO NEXT STEP
  else
    setTimeout(function() {
        document.querySelector('.voyante').classList.remove('d-none');
      }, 15000);
    }
  }



export { firstNight, otherNight, endOfNight };
