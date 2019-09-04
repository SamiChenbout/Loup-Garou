


const play = () => {
  const audio = new Audio('../../assets/audios/whatislove.mp3');
  const audiodiv = document.getElementById("audiodiv");
  if (audiodiv) {
  console.log('hello!')
    audio.play();
  };
};

export { play }



