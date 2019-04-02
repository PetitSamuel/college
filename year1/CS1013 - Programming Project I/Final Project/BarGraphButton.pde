/* @author Jevgenijus Cistiakovas
*  This class is an extension to Button class. The only difference is that instead of label, a small picture of a bar graph is drawn.
*/
class BarGraphButton extends Button {

  BarGraphButton(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, 
    int widgetWidth, PFont font, int event) {

    super( x, y, "", widgetColor, textColor, widgetHeight, 
      widgetWidth, font, event) ;
  }
  
  void show(){
    super.show();
    // draw an small image of a bar graph
    
    float barUnitWidth = getWidgetWidth() / 6;
    float barUnitHeight = getWidgetHeight() / 10;
    stroke(0);
    rectMode(CORNER);
    fill(getTextColor());
    // bars
    rect(getX() + barUnitWidth, getY() + 2*barUnitHeight, barUnitWidth, 6*barUnitHeight);
    rect(getX() + 2*barUnitWidth, getY() + 5*barUnitHeight,barUnitWidth, 3*barUnitHeight);
    rect(getX() + 3*barUnitWidth, getY() + 4*barUnitHeight,barUnitWidth, 4*barUnitHeight);
    rect(getX() + 4*barUnitWidth, getY() + 3*barUnitHeight,barUnitWidth, 5*barUnitHeight);
  
  }
}