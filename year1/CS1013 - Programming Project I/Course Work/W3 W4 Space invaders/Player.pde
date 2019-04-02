class Player {
  int xpos; int ypos;
  color paddlecolor = color(255);
  PImage playerImg;
  int bulletMode;
  boolean alive;
  Player(int screen_y,   PImage img)
  {
    alive = true;
    playerImg = img;
    xpos=SCREENX/2;
    ypos=screen_y;
    bulletMode = 0;
  }
  void move(int x){
    if(x>SCREENX-PLAYER_WIDTH) xpos = SCREENX-PLAYER_WIDTH;
    else xpos=x;
  }
  void draw()
  {
    image(playerImg, xpos, ypos);
   // rect(xpos, ypos, PLAYER_WIDTH, PLAYER_HEIGHT);
  }
}