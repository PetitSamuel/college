class Circle {
int x, y; int radius=10;
color circleColor;
Circle (int xpos, int ypos) {
x=xpos; y=ypos;
circleColor = color(int(random(0,255)),
int(random(0,255)),int(random(0,255)));
}
void draw(){
fill(circleColor);
ellipse(x, y, radius, radius);
}
void move(int targetX, int targetY){
if(x<targetX) x++; else x--;
if(y<targetY) y++; else y--;
}
}