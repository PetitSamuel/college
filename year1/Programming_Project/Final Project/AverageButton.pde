/* @author Jevgenijus Cistiakovas
*  This class is an extension to Button class. The only difference is that instead of label, a small picture representing average is displayed.
*/

class AverageButton extends Button{

  AverageButton(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, 
    int widgetWidth, PFont font, int event) {

    super( x, y, "", widgetColor, textColor, widgetHeight, 
      widgetWidth, font, event) ;
  }
  
  void show(){
    super.show();
    // draw an small image of a bar graph
    
    float unitWidth = getWidgetWidth() / 20;
    float unitHeight = getWidgetHeight() / 10;
    //stroke(0);
    //strokeWeight(1);
    //rectMode(CORNER);
    //fill(getTextColor());
    //ellipseMode(CENTER);
    //arc(getX() + 10 *unitWidth, getY() + 8 * unitHeight, 16*unitWidth, 13*unitHeight, PI, 2*PI);
    //strokeWeight(2);
    //line(getX() + 10 *unitWidth, getY() + 8 * unitHeight, getX() + 14 *unitWidth,getY() + 5 * unitHeight);
    textSize((getWidgetHeight() + getWidgetWidth()) / 5);
    stroke(getTextColor());
    strokeWeight(2);
    rectMode(CORNER);
    fill(getTextColor());
    text("x", getX() + 10*unitWidth, getY() + 5 * unitHeight);
    line(getX() + 10*unitWidth- + 0.5*textWidth('x'), getY() + 5 * unitHeight - 0.5*textAscent(), getX() + 10*unitWidth + 0.5*textWidth('x'),  getY() + 5 * unitHeight - 0.5*textAscent());
  }

}