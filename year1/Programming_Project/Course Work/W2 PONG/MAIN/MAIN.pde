Player thePlayer;
Player theComputer;
Ball theBall;
boolean reset;
PFont font;
int speed;

void settings(){
  size(SCREENX, SCREENY);
  font = loadFont("Arial-Black-18.vlw");
  speed = 1;

}
void setup(){
  thePlayer = new Player(SCREENY-(MARGIN+PADDLEHEIGHT));
  theComputer = new Player(MARGIN + PADDLEHEIGHT);
  theBall = new Ball();
  ellipseMode(RADIUS);
  reset = false;
 
}
void draw() {
 
  background(0);
    if(frameCount % 500 == 0)
    {
      speed++;
    }
  thePlayer.move(mouseX);
  for(int i = 0; i < speed; i++)
  {
    theBall.move();
    theComputer.moveAI(theBall.x);
    theBall.collidePlayer(thePlayer);
    theBall.collideComputer(theComputer);
    theBall.collideWall();
  }
  theBall.draw();    
  theComputer.draw();
  thePlayer.draw();
  textFont(font, 18);
  text("Difficulty : " + speed, 20, 20);
  textFont(font, 10);
  text("lives left : " + (3 - thePlayer.winCount), 300, 20);
  text("lives left : " + (3 - theComputer.winCount), 300, SCREENY);
  if(theBall.outOfCanvas(theBall.y))
  {
    reset = true;
    if(theComputer.winCount == 2 && theBall.y >= SCREENX)
     {
      textFont(font, 18);
      println("Computer score : 3");
      text("GAME OVER", 95, SCREENY/2);
      frameRate(0);
   }
    else if(thePlayer.winCount == 2 && theBall.y <= 0)
    {
      textFont(font, 18);
      println("Player score : 3");
      text("YOU BEAT THE COMPUTER", 35, SCREENY/2);
      frameRate(0);
    }
  }
}

void mousePressed(){
  if(reset)
  {
    if(theBall.y <= 0)
   {
   thePlayer.scoreUpdate(); //<>//
   }
   else if(theBall.y >= SCREENX)
   { 
     theComputer.scoreUpdate(); //<>//
   }
   reset = false; 
   theBall = new Ball(); 
   speed = 1;
  }
}