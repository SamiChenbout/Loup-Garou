const mycheckTwo = () => {
  if(document.querySelector('.checkTwo')) {
    document.querySelectorAll('.mycheck').forEach(function(element) {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        let count = 0;
        document.querySelectorAll('.mycheck').forEach(function(thing) {
          if(thing.querySelector('input').checked) {
            count = count + 1;
          };
        });
        if(event.currentTarget.querySelector('input').checked === false && count < 2) {
          event.currentTarget.querySelector('label').classList.add('checked');
          event.currentTarget.querySelector('input').checked = true;
        } else if(event.currentTarget.querySelector('input').checked){
          event.currentTarget.querySelector('label').classList.remove('checked');
          event.currentTarget.querySelector('input').checked = false;
        };
      });
    });
  };
};

const mycheckOne = () => {
  if(document.querySelector('.checkOne')) {
    document.querySelectorAll('.mycheck').forEach(function(element) {
      element.addEventListener('click', (event) => {
        event.preventDefault();
        document.querySelectorAll('.mycheck').forEach(function(thing) {
          thing.querySelector('label').classList.remove('checked');
          thing.querySelector('input').checked = false;
        });
        event.currentTarget.querySelector('label').classList.add('checked');
        event.currentTarget.querySelector('input').checked = true;
      });
    });
  };
};


export { mycheckTwo, mycheckOne };
