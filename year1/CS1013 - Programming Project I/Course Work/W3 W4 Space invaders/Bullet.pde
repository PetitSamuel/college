class Bullet {
  int x; int y;
  color bulletColor = color(255, 0, 127);
  Bullet(int xPlayer, int yPlayer){
    x = xPlayer + (PLAYER_WIDTH / 2);
    y = yPlayer - 2;
  }
  
  void draw(){
     strokeWeight(3); 
     fill(bulletColor);
     rect(x, y, BULLETWIDTH, BULLETHEIGHT);
  }
  
  void move(){
    y-= 2;    
  }
  
  void collide (Alien [] array){
    for(int i = 0; i < array.length; i++){
      if(x + BULLETWIDTH > theAliens[i].x && x - BULLETWIDTH < theAliens[i].x + ALIEN_WIDTH && y - BULLETHEIGHT < theAliens[i].y + ALIEN_HEIGHT && y + BULLETHEIGHT > theAliens[i].y)
       theAliens[i].die();
     }
  }
  

}