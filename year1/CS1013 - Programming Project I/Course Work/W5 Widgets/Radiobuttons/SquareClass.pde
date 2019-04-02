class Square{
  int x,y, height, width;
  color notSelected, selected, squareColor;
  
  
  Square(int xpos, int ypos, int height, int width, color setColor){
    this.x = xpos;
    this.y = ypos;
    this.squareColor = setColor;
    this.height = height;
    this.width = width;
  }
  
  void draw(){
     noStroke();
    fill(this.squareColor);
    rect(x, y, height, width);
  } 
}