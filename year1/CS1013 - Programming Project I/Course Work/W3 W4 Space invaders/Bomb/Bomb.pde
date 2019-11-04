class Bomb{
 int x, y;
 color bulletColor = color(255, 0, 0);
 
 Bomb(int xpos, int ypos){
  x = xpos;
  y = ypos;
   
 }
  
  void move(){
   y++; 
  }
  
  void draw(){
    fill(bulletColor);
   rect(x, y, BOMB_RADIUS, BOMB_RADIUS); 
  }
  
  Boolean offScreen(){
   return y - BOMB_RADIUS > SCREENY;
  }
  
  boolean collide(Player tp){
    return (x + BOMB_RADIUS >= tp.xpos && x <= tp.xpos + PLAYER_WIDTH && y + BOMB_RADIUS >= tp.ypos && y <= tp.ypos + PLAYER_HEIGHT);
 }
  
}