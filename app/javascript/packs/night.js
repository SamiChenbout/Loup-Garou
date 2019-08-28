const firstNight = () => {
  if(document.querySelector('.firstNight')) {
    setTimeout(function() {
      document.querySelector('.cupidon').classList.remove('d-none');
      console.log("coucou cupidon");
    }, 20000);
    setTimeout(function() {
      document.querySelector('.cupidon').classList.add('d-none');
      document.querySelector('.voyante').classList.remove('d-none');
    }, 20000);
    setTimeout(function() {
      document.querySelector('.voyante').classList.add('d-none');
      document.querySelector('.loup').classList.remove('d-none');
    }, 30000);
    setTimeout(function() {
      document.querySelector('.voyante').classList.add('d-none');
      document.querySelector('.loup').classList.remove('d-none');
    }, 30000);
    endOfNight();
  };
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
    GO TO NEXT STEP
  else
    setTimeout(function() {
        document.querySelector('.voyante').classList.remove('d-none');
      }, 15000);
    }
  }

const loups = () => {
  if (document.querySelector('.loups').classList.contains('d-none')) {
    GO TO NEXT STEP
  else
    setTimeout(function() {
        document.querySelector('.loups').classList.remove('d-none');
      }, 30000);
    }
  }


export { firstNight, otherNight, endOfNight };
