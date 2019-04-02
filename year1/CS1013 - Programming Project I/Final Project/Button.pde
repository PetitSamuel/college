/*
@authors : Petit Samuel and David Hooban

*/
class Button extends Widget
{
  boolean state;
  int event;
  Button(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, 
    int widgetWidth, PFont font, int event) 
  {
    super(x, y, widgetText, widgetColor, textColor, widgetHeight, widgetWidth, font);
    this.event = event;
    state = false;
  }


  void show()
  {
    noStroke();
    rectMode(CORNER);
    if (isOverButton(mouseX, mouseY)) {
      fill(180);
    } else {
      fill(widgetColor);
    }
    rect(this.x, this.y, this.widgetWidth, this.widgetHeight);
    fill(textColor);
    textFont(font, 15);
    textAlign(CENTER, CENTER);
    text(widgetText, x, y, widgetWidth, widgetHeight);
  }

  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+widgetWidth && mY > y && mY <y+widgetHeight) {
      return event;
    }
    return EVENT_NULL;
  }
  void setWidth(int w) {
    this.widgetWidth = w;
  }  

  boolean isOverButton(int mX, int mY) {
    if (mX>x && mX < x+widgetWidth && mY >y && mY <y+widgetHeight) {
      return true;
    } else {
      return false;
    }
  }
  void setPos(int x, int y) {
    this.x = x;
    this.y = y;
  }
}