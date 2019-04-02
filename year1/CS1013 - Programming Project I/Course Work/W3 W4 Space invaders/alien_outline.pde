import processing.sound.*;
SoundFile winSound, shootSound, dieSound, hitSound;
Alien theAliens[];
Player thePlayer;
Shield shield;
ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
ArrayList<Bomb> bombsList = new ArrayList<Bomb>();
PFont font;

/* Set the window size, load the images, create the empty array of Aliens and call init_array to fill it in. */
void settings(){
   size(SCREENX, SCREENY);
}

void setup(){
  font = loadFont("Calibri-20.vlw");
  PImage normalImg, explodeImg, alienFiring;
  normalImg = loadImage("spacer_ae.png");
  explodeImg = loadImage("explo_ae.png");
  alienFiring = loadImage("alien_fire2.jpg");
  theAliens = new Alien[10];
  shield = new Shield();
  thePlayer = new Player(SCREENY-(MARGIN+PLAYER_HEIGHT), alienFiring);
  init_aliens(theAliens, normalImg, explodeImg);
  init_sounds();
}

// Fill in the array with new Alien objects
void init_aliens(Alien baddies[], PImage okImg, PImage exImg){
  for(int i=0; i<baddies.length; i++){
// There is a problem with this code, can you spot it?
    baddies[i] = new Alien(MARGIN+i*(okImg.width+GAP), MARGIN, okImg, exImg);
  }
}

void init_sounds(){
  shootSound = new SoundFile(this, "pew.mp3");
  winSound = new SoundFile(this, "win.mp3");
  dieSound = new SoundFile(this, "diesound.mp3");
  hitSound = new SoundFile(this, "punch.mp3");
}

/* Move each Alien down the screen and draw it. Kill the aliens at random. */
void draw(){ 
  background(0);
  thePlayer.move(mouseX);
  thePlayer.draw();
  bulletsUpdate();
  aliensUpdate();
  bombsUpdate();
  
  if(shield.protecting){
  shield.hit(bulletList, bombsList, hitSound);
  shield.draw();
  }
}

void bulletsUpdate(){
  for(int i=0; i<bulletList.size(); i++){
    bulletList.get(i).move();
    bulletList.get(i).draw();
    bulletList.get(i).collide(theAliens);
    if(bulletList.get(i).y + BULLETHEIGHT < 0){
      bulletList.remove(i);
    }
  }
}

void aliensUpdate(){
  boolean win = true;
    for(int i=0; i<theAliens.length; i++){
    theAliens[i].move();
    theAliens[i].draw();
    theAliens[i].collisionPowerUp(thePlayer.xpos, thePlayer.ypos, thePlayer);
    if(random(0, 2000)<1 && !theAliens[i].bonus && theAliens[i].status==ALIEN_ALIVE)theAliens[i].powerUp();
    if(random(0, 1000)<1 && !theAliens[i].droppedBomb && theAliens[i].status==ALIEN_ALIVE){
      bombsList.add(new Bomb(theAliens[i].x, theAliens[i].y));
      theAliens[i].droppedBomb = true;
    }
    if(theAliens[i].status == ALIEN_ALIVE) win = false;
  }
  
  if(win){
     winSound.play();
     textFont(font, 35);
     fill(255);
     text("You won!", SCREENX/3, SCREENY/2); 
     noLoop();
  }
    
}

void bombsUpdate(){
   for(int i = 0; i < bombsList.size(); i++){
    bombsList.get(i).draw();
    bombsList.get(i).move();
   if(bombsList.get(i).collide(thePlayer)){
     textFont(font, 35);
     dieSound.play();
     fill(255);
     text("You lost", SCREENX/3, SCREENY/2); 
     noLoop();
    }
    if(bombsList.get(i).offScreen()){
      bombsList.remove(i);
    }
  }
}

void mousePressed(){
  shootSound.play();
  if(thePlayer.bulletMode == 1){
    bulletList.add(new Bullet(thePlayer.xpos - 20, thePlayer.ypos));
    bulletList.add(new Bullet(thePlayer.xpos + 20, thePlayer.ypos));
  } else if(thePlayer.bulletMode == 2){
    bulletList.add(new Bullet(thePlayer.xpos - 20, thePlayer.ypos));
    bulletList.add(new Bullet(thePlayer.xpos + 20, thePlayer.ypos));
    bulletList.add(new Bullet(thePlayer.xpos, thePlayer.ypos));
  } else { 
      bulletList.add(new Bullet(thePlayer.xpos, thePlayer.ypos));
  }
}