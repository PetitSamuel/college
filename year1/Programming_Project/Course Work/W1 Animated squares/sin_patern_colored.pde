int x = - 40;
int x1 = - 40;
boolean A = false;
float y;

float r;
float g;
float b;
float r1;
float g1;
float b1;
void setup(){
 size(300, 500); 
}

void draw(){
  if(frameCount % 50 == 0)
  {
    r = random(255);
    g = random(255);
    b = random(255);
    
    r1 = random(255);
    g1 = random(255);
    b1 = random(255); 
  }
 background(0);
 fill(r, g, b);
 rect(x, 125 +  (sin(y) * 100), 40, 40);
  fill(r, g, b);
 rect(x1, 125 +  (sin(y) * 100), 40, 40);
 fill(r1, g1, b1);
 rect(260 - x, 300 + (cos(y) * 100), 40, 40);
 fill(r1, g1, b1);
 rect(260 - x1, 300 + (cos(y) * 100), 40, 40);
y += 0.05;
 x += 2;
 
 if(x == 260) A = true;
 if(A) x1 += 2;
 if(x1 == 260) x = -40;
 if(x == 260) x1 = - 40;
}