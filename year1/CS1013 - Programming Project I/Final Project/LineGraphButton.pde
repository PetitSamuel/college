/* @author Jevgenijus Cistiakovas
*  This class is an extension to Button class. The only difference is that instead of label, a small picture of a line graph is drawn.
*/

class LineGraphButton extends Button{

  LineGraphButton(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, 
    int widgetWidth, PFont font, int event) {

    super( x, y, "", widgetColor, textColor, widgetHeight, 
      widgetWidth, font, event) ;
  }
  
  void show(){
    super.show();
    // draw an small image of a bar graph
    
    float unitWidth = getWidgetWidth() / 20;
    float unitHeight = getWidgetHeight() / 10;
    stroke(0);
    strokeWeight(3);
    rectMode(CORNER);
    //axes
    line(getX() + 4*unitWidth, getY() + 2*unitHeight, getX() + 4*unitWidth, getY() + 8*unitHeight);    // y-xis
    line(getX() + 4*unitWidth, getY() + 8*unitHeight, getX() + 16*unitWidth, getY() + 8*unitHeight);    // x-axis
    // lines
    line(getX() + 4*unitWidth, getY() + 8*unitHeight, getX() + 7*unitWidth, getY() + 5*unitHeight);
    line(getX() + 7*unitWidth, getY() + 5*unitHeight, getX() + 9*unitWidth, getY() + 6*unitHeight);
    line(getX() + 9*unitWidth, getY() + 6*unitHeight, getX() + 12*unitWidth, getY() + 3*unitHeight);
    line(getX() + 12*unitWidth, getY() + 3*unitHeight, getX() + 14*unitWidth, getY() + 4*unitHeight);
    line(getX() + 14*unitWidth, getY() + 4*unitHeight, getX() + 16*unitWidth, getY() + 2*unitHeight);
    stroke(getTextColor());
    strokeWeight(2);
    rectMode(CORNER);
    //axes
    line(getX() + 4*unitWidth, getY() + 2*unitHeight, getX() + 4*unitWidth, getY() + 8*unitHeight);    // y-xis
    line(getX() + 4*unitWidth, getY() + 8*unitHeight, getX() + 16*unitWidth, getY() + 8*unitHeight);    // x-axis
    // lines
    line(getX() + 4*unitWidth, getY() + 8*unitHeight, getX() + 7*unitWidth, getY() + 5*unitHeight);
    line(getX() + 7*unitWidth, getY() + 5*unitHeight, getX() + 9*unitWidth, getY() + 6*unitHeight);
    line(getX() + 9*unitWidth, getY() + 6*unitHeight, getX() + 12*unitWidth, getY() + 3*unitHeight);
    line(getX() + 12*unitWidth, getY() + 3*unitHeight, getX() + 14*unitWidth, getY() + 4*unitHeight);
    line(getX() + 14*unitWidth, getY() + 4*unitHeight, getX() + 16*unitWidth, getY() + 2*unitHeight);
  }

}