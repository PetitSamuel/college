
// authors : Samuel petit, David Hooban &  J.Cistiakovas. Parent class to all widgets.

// J.Cistiakovas 22/03 added boolean object var focus that represents whether a mouse is currently over the widget. Added getter and setter for focus.
static class Widget
{
  int x, y;
  public String widgetText;
  color widgetColor;
  color textColor;
  int widgetHeight, widgetWidth;
  PFont font;
  boolean focus;

  Widget(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, 
    int widgetWidth, PFont font) {
    this.x = x;
    this.y = y;
    this.widgetText = widgetText;
    this.widgetColor = widgetColor;
    this.textColor = textColor;
    this.widgetHeight = widgetHeight;
    this.widgetWidth = widgetWidth;
    this.font = font;
    this.focus = false;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public String getWidgetText() {
    return widgetText;
  }

  public color getWidgetColor() {
    return widgetColor;
  }
  public void setWidgetColor(color widgetColor) {
    this.widgetColor = widgetColor;
  }

  public color getTextColor() {
    return textColor;
  }

  public void setTextColor(color textColor) {
    this.textColor = textColor;
  }

  public int getWidgetHeight() {
    return widgetHeight;
  }

  public int getWidgetWidth() {
    return widgetWidth;
  }
  PFont getFont() {
    return font;
  }

  void setWidgetText(String widgetText) {
    this.widgetText = widgetText;
  }
  void setFocus(boolean focus) {
    this.focus = focus;
  }

  boolean getFocus() {
    return focus;
  }
}