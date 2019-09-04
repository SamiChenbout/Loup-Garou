const scroll_down = () => {
            window.setInterval(function() {
              const elem = document.querySelector('.message-box');
              elem.scrollIntoView(false);
              console.log(elem.scrollHeight)
            }, 500);
          }


export { scroll_down };
