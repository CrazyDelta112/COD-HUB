// Get game elements
const gameElements = document.querySelectorAll('[data-id="game"]');

Array.from(gameElements).forEach((gameElement) => {
  gameElement.addEventListener('mouseover', () => {

    gameElement.classList.add('is-active');
    Array.from(gameElements)
      .filter((globalGameElement) => {
        return globalGameElement !== gameElement;
      })
      .forEach((otherGameElemenet) => {
        otherGameElemenet.classList.remove('is-active');
      });
  });
});

const playButtons = document.querySelectorAll('.play-button');
const hoverSound = new Audio('Sounds/IW8/hover3.wav');
const clickSound = new Audio('DONT TOUCH I HATE THE SOUND!'); // som do clique

playButtons.forEach(button => {
  
  // som ao passar o mouse
  button.addEventListener('mouseover', () => {
    hoverSound.currentTime = 0; 
    hoverSound.play();
  });

  // som ao clicar
  button.addEventListener('click', () => {
    clickSound.currentTime = 0;
    clickSound.play();
  });

});
i