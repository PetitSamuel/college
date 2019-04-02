class Widget {
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor, strokeColor;
  PFont widgetFont;

  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event; 
    this.widgetColor=widgetColor; this.widgetFont=widgetFont;
    labelColor= color(0);
    this.strokeColor = color(0,0,0);
   }
  void draw(){
    strokeWeight(2);
    stroke(this.strokeColor);
    fill(widgetColor);
    rect(x,y,width,height);
    fill(labelColor);
    text(label, x+10, y+height-10);
  }
  int getEvent(int mX, int mY){
     if(mX>x && mX < x+width && mY >y && mY <y+height){
        return event;
     }
     return EVENT_NULL;
  }
  boolean isOverButton(int mX, int mY){
    if(mX>x && mX < x+width && mY >y && mY <y+height){
      return true;
    } else {
      return false;
    }
  }
    void changeStroke(boolean mouseOverSquare){
    if(mouseOverSquare){
      this.strokeColor = color(255,255,255);
    } else {
       this.strokeColor = color(0,0,0);
    }
  }
}