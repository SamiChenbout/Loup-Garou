const firstNight = () => {
  if(document.querySelector('.firstNight')) {
    randomCouple();
  };
}

const randomCouple = () => {
  document.querySelector('.cupidon').classList.remove('d-none');
  setTimeout(function() {
    $(".edit").click(function(){
      if (document.querySelector('.cupidon').hasClass("update") === false){
        $.ajax({
          type: "POST",
          url: "/games/<% @game.id %>/random_couple"
        });
      };
    })
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

export { firstNight, otherNight, endOfNight };
