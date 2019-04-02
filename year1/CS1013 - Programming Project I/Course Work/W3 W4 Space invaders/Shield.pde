class Shield{
 int x, y, livesCount;
 color shieldColour = color(165, 42, 42);
 boolean protecting;
 
 Shield(){
   x = (int) random(SCREENX - SHIELD_WIDTH);
   y = (int) random(SCREENY / 2, SCREENY - (PLAYER_HEIGHT * 2));
   protecting = true;
   livesCount = 5;
 }
 
 void draw(){
   fill(shieldColour);
  rect(x, y, SHIELD_WIDTH, SHIELD_HEIGHT); 
 }
 
 void hit(ArrayList<Bullet> bullets, ArrayList<Bomb> bombs, SoundFile hit){
  for(int i = 0; i < bombs.size(); i++){
    if((bombs.get(i).x + BOMB_RADIUS >= x) && (bombs.get(i).x <= x + SHIELD_WIDTH) && (bombs.get(i).y + BOMB_RADIUS >= y) && (bombs.get(i).y <= y + SHIELD_HEIGHT)){
     livesCount--;
     bombs.remove(i);
     hit.play();
    } 
  }
  for(int i = 0; i < bullets.size(); i++){
    if(bullets.get(i).x + BULLETWIDTH >= x && bullets.get(i).x <= x + SHIELD_WIDTH && bullets.get(i).y + BULLETHEIGHT >= y && bullets.get(i).y <= y + SHIELD_HEIGHT){
     livesCount-= 3;
     bullets.remove(i);
     hit.play();
    }
   }
  println(livesCount);
  
  if(livesCount <= 0) protecting = false;
 }
}