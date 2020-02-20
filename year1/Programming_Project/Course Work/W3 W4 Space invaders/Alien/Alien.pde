final int ALIEN_ALIVE=0;
final int ALIEN_DEAD=16;
final int FORWARD=0;
final int BACKWARD=1;

class Alien {
  int x, y, direction;
  int status;
  boolean bonus, droppedBomb;
  int bombSimulation;
  PImage normalImg, explodeImg;
  int xBonus; int yBonus;
  color bonusColor;
  int bonusType;

// The constructor is passed the position of the Alien on screen
// and the images to use
  Alien (int xpos, int ypos, PImage okImg, PImage exImg){
    x = xpos; 
    y = ypos;
    status = ALIEN_ALIVE;
    bonus = false;
    droppedBomb = false;
    normalImg=okImg; 
    explodeImg=exImg;
    direction=FORWARD;
  }
  
  /*If we are moving forward, check to see if we have hit the right
   hand side of the window, if moving backward, check to see if we
   have hit the left hand side of the window. */
    void move(){
      if(!droppedBomb){
        bombSimulation = y;
      } else{
       bombSimulation = bombSimulation + 1; 
       if(bombSimulation >= SCREENY + BOMB_RADIUS){
         droppedBomb = false;
       }
      }
     
      if(direction==FORWARD){
        if(x+normalImg.width<SCREENX-MARGIN-1)
          x++;
        else{
          direction=BACKWARD;
          y+=normalImg.height+GAP;
        }
      }
      else if(x>MARGIN+1) x--;
      else {
        direction=FORWARD;
        y+=normalImg.height+GAP;
      }
  
  
     if(bonus){
       yBonus+= 2;
      }
    }
  
  /* If we are alive, draw the alien
   if we are exploding, draw the explosion
   and move on to the next "exploding" state
   if we are dead, don't draw anything. */
    void draw(){
      if(status==ALIEN_ALIVE)
        image(normalImg, x, y);
      else if(status!=ALIEN_DEAD){
        image(explodeImg, x, y);
        status++;
      }
      // otherwise dead, don't draw anything
  
    if(bonus){
      fill(bonusColor);
      rect(xBonus, yBonus, BONUS_WIDTH, BONUS_HEIGHT);
    }
  }
    
  /* Start exploding. */
    void die(){
      if(status==ALIEN_ALIVE)
        status++;
    }
    
    void powerUp(){
     bonusType = (int) random(3);
     bonus = true;
     xBonus = x + ALIEN_WIDTH / 2;
     yBonus = y + ALIEN_HEIGHT;
     if(bonusType == 0){
       bonusColor = color(255, 100, 0);
     } else if (bonusType == 1){
       bonusColor = color(0, 255, 0);
     } else {
       bonusColor = color(0, 0, 255);
     }
  }
  
  void collisionPowerUp(int xPlayer, int  yPlayer, Player tp){
    if(xBonus - BONUS_WIDTH >= xPlayer && xBonus <= xPlayer + PLAYER_WIDTH && yBonus + BONUS_HEIGHT >= yPlayer && yBonus <= yPlayer + PLAYER_HEIGHT){
    bonus = false;
    tp.bulletMode = bonusType;
    xBonus = 0;
    yBonus = 0; 
    }
    else if(yBonus >= SCREENY){
     bonus = false;  
     xBonus = 0;
     yBonus = 0; 
     }
   }
  
}