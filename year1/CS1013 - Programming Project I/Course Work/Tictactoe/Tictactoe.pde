char playerChar = ' ';
int count;
GameDisplay gameArea;
GameCalculations backgroundActions;
boolean endGame;
boolean win;
boolean reset;
void settings(){
    size(SCREENX, SCREENY);
    font = loadFont("Arial-Black-18.vlw");  
}
void setup(){
  gameArea = new GameDisplay();
  backgroundActions = new GameCalculations();
  count = 0;
  endGame = false;
  win = false;
  reset = false;
}

void draw(){
  background(0);
  gameArea.draw();
  backgroundActions.draw();
  playerChar = (count % 2 == 0)? 'X':'O';
  textFont(font, 15);
  text("Playing : " + playerChar, 20, 20);

  if(endGame){
    noStroke();
   fill(0, 0, 255);
   rect(0, 225, SCREENY, 80);
   textFont(font, 15);
   fill(255);
   if(win) text("Player " + ((count % 2 == 0)? 'O':'X') + " has won!", 75, 250);
   else text("The board is full, there is no winner", 5, 250);
   text("Click here to play again", 50, 280); 
  }
}

void mousePressed(){
  if(!endGame){
    backgroundActions.getRowAndColumn(mouseX, mouseY);
    if(backgroundActions.canMakeMove(backgroundActions.row, backgroundActions.column)){ 
      backgroundActions.makeMove(backgroundActions.row, backgroundActions.column, playerChar);
      count++;
        if(backgroundActions.winner() != ' '){
          endGame = true;
          win = true;
        }
        else if(backgroundActions.isBoardFull()) endGame = true;

    }
  }
  if(endGame && backgroundActions.clickToReset(mouseX, mouseY)) setup();
}