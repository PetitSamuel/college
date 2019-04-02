class Ball {
  float x; float y;
  float dx; float dy;
  int radius;
  color ballColor = color(250, 10, 200);
 
  Ball(){
    x = random(SCREENX/4, SCREENX/2);
    y = random(SCREENY/4, SCREENY/2);
    dx = random(-2 , 2); dy = random(1, 2);
    radius=15;
  }
  void move(){
    x = x+dx; y = y+dy;
}
  void draw(){
    fill(ballColor);
    ellipse(int(x), int(y), radius, radius);
  }
  void collideWall(){
    if(x-radius <=0) dx=-dx;
    else if(x+radius>=SCREENX) dx=-dx;
  }
  void collidePlayer(Player tp){
    if(y+radius >= tp.ypos && y-radius<tp.ypos+PADDLEHEIGHT && x >=tp.xpos && x <= tp.xpos+PADDLEWIDTH){
      float a = map(x, tp.xpos, tp.xpos + PADDLEWIDTH, -2, 2);
      dx += a;
      dy=-dy;
    }
  }
     void collideComputer(Player tp){
    if(y-radius <= tp.ypos + PADDLEHEIGHT && y>tp.ypos && x >=tp.xpos && x <= tp.xpos+PADDLEWIDTH){
      float a = map(x, tp.xpos, tp.xpos + PADDLEWIDTH, -2, 2);
      dx += a;
      dy = -dy;
    }
  }
  
  boolean outOfCanvas(float y)
  {
    if(y- radius <= 0 || y + radius >= SCREENY) return true;
    else return false;
  }
}