const modalRegle = () => {
  if(document.querySelector('.modal-rules-container')) {
    document.querySelector('.book').addEventListener('click', (event) => {
      document.querySelector('.modal-rules-container').classList.remove('d-none');
      document.querySelector('.allHome').style.filter = "brightness(50%)";
      document.querySelector('.croix-container-rules').addEventListener('click', (event) => {
        document.querySelector('.modal-rules-container').classList.add('d-none');
        document.querySelector('.allHome').style.filter = "brightness(100%)";
      });
    });
  };
};

const modalParams = () => {
  if(document.querySelector('.modal-params-container')) {
    document.querySelector('.parameter').addEventListener('click', (event) => {
      document.querySelector('.modal-params-container').classList.remove('d-none');
      document.querySelector('.allHome').style.filter = "brightness(50%)";
      document.querySelector('.croix-container-params').addEventListener('click', (event) => {
        document.querySelector('.modal-params-container').classList.add('d-none');
        document.querySelector('.allHome').style.filter = "brightness(100%)";
      });
    });
  };
};

export { modalRegle, modalParams };
