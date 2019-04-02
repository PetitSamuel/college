final color SELECTED = color(20, 20, 240);
final color NOT_SELECTED = color(200);

PFont stdFont;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_NULL=0;
Square square1, square2, square3, square4;
Widget widget1, widget2, widget3, widget4;
ArrayList widgetList1;
Screen screen1, screen2, screen3;
ArrayList screenList;
int currentScreen;

void setup(){
  currentScreen = 0;
  stdFont=loadFont("Arial-BoldMT-40.vlw");
  textFont(stdFont);

  widget1=new Widget(100, 100, 180, 40,
  "selection1", color(255,0,0),
  stdFont, EVENT_BUTTON1);
  widget2=new Widget(100, 200, 180, 40,
  "no, me!", color(0,255,0),
  stdFont, EVENT_BUTTON2);     
  size(400, 400);
  
  widgetList1 = new ArrayList();
  widgetList1.add(widget1); widgetList1.add(widget2);



  square1 = new Square(60, 100, 30, 30, NOT_SELECTED);
  square2 = new Square(60, 200, 30, 30, NOT_SELECTED);
  square3 = new Square(60, 100, 30, 30, SELECTED);
  square4 = new Square(60, 200, 30, 30, SELECTED);
  screenList = new ArrayList();
  screenList.add(new Screen(widgetList1, square1, square2, color(20, 100, 20)));
  screenList.add(new Screen(widgetList1, square3, square2, color(100, 20, 20)));  
  screenList.add(new Screen(widgetList1, square1, square4, color(20, 20, 100)));
}

void draw(){
   Screen tmp =(Screen) screenList.get(currentScreen);
   tmp.draw();
}

void mousePressed(){
   Screen tmp =(Screen) screenList.get(currentScreen);
   currentScreen = tmp.getEvent(currentScreen);
}

void mouseMoved(){
   Screen tmp =(Screen) screenList.get(currentScreen);
   tmp.mouseMovedEvent();
}