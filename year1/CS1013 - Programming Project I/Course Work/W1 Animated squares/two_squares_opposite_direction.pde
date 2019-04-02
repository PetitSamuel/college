int x = - 40;
int x1 = - 40;
boolean A = false;
void setup(){
 size(300, 300); 
}

void draw(){
  background(0);
  fill(255, 0, 0);
 rect(x, 40, 40, 40);
 rect(x1, 40, 40, 40);
 
 rect(260 - x, 200, 40, 40);
 rect(260 - x1, 200, 40, 40);

 x += 2;
 
 if(x == 260) A = true;
 if(A) x1 += 2;
 if(x1 == 260) x = -40;
 if(x == 260) x1 = - 40;
}