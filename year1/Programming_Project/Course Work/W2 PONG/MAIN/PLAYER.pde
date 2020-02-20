class Player {
  int xpos; int ypos;
  color paddlecolor = color(190, 255, 0);
  int winCount = 0;

  Player(int screen_y)
  {
    speed = 1;
    xpos=SCREENX/2;
    ypos=screen_y;
  }
  void move(int x){
    if(x>SCREENX-PADDLEWIDTH) xpos = SCREENX-PADDLEWIDTH;
    else xpos=x;
  }
    void moveAI(float x){
      if(x > xpos + PADDLEWIDTH/2 && xpos + PADDLEWIDTH < SCREENX) xpos++;
      else if(x < xpos + PADDLEWIDTH/2 && xpos  > 0) xpos--;
  } 
  void draw()
  {
    fill(paddlecolor);
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
  void scoreUpdate(){
    winCount = winCount + 1;
  }
}