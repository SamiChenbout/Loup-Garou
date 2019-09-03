const animation = () => {
  if (document.getElementById('animation-page')) {
    console.log('test');
    setTimeout(() => {
      window.location = "/find"
    }, 5000000);
  }
}

export { animation };

