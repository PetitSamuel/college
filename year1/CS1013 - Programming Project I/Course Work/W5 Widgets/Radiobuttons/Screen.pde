class Screen{
 ArrayList<Widget> widList;
 Square square1, square2;
 color backgroundColor;
  Screen(ArrayList<Widget> list,Square square, Square secondSquare, color background){
    this.widList = list;
    this.backgroundColor = background;
    this.square1 = square;
    this.square2 = secondSquare;
  }
  void draw(){
    background(this.backgroundColor);
  for(int i = 0; i<this.widList.size(); i++){
    Widget aWidget = (Widget)this.widList.get(i);
    aWidget.draw();
   } 
  this.square1.draw();
  this.square2.draw();
  }
  int getEvent(int current){
   int event;
   for(int i = 0; i<this.widList.size(); i++){
    Widget aWidget = (Widget) this.widList.get(i);
    event = aWidget.getEvent(mouseX,mouseY);
  if(event != 0) return event;
  } 
  return current;
 }
 
 void mouseMovedEvent(){
   for(int i = 0; i<this.widList.size(); i++){
       Widget aWidget = (Widget)this.widList.get(i);
       aWidget.changeStroke(aWidget.isOverButton(mouseX, mouseY));
   } 
 }
}