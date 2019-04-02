class Square{
  int x,y, height, width;
  color squareColor;
  
  Square(int xpos, int ypos, color inputColor, int height, int width){
    this.x = xpos;
    this.y = ypos;
    this.squareColor = inputColor;
    this.height = height;
    this.width = width;
  }
  
  void draw(){
     noStroke();
    fill(this.squareColor);
    rect(x, y, height, width);
  }
  
  void changeColor(color inputColor){
    this.squareColor = inputColor;    
  }  
}