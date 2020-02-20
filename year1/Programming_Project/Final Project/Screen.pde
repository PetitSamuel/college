/*
  Author : samuel petit and David Hooban : - class which gets everything that needs to be displayed on a single screen : graphs, review box, search bars...

*/

class Screen
{
  private ArrayList <Button> widgetList;
  private String displayMessage;
  color backgroundColor;
  reviewsBoxWidget reviewbox;
  PFont font;
  ArrayList <BarGraph> graphs;
  boolean focus;
  LineGraph lineG;
  AvgStar avgSingleBarGraph;
  MapWidget map;
  String [] hours;
  String categories;
  boolean opened_b;
  int currentGraph;
  Screen(ArrayList <Button> widgetList, reviewsBoxWidget reviewbox, color backgroundColor, String displayMessage, PFont font)
  {
    this.graphs = new ArrayList();
    this.widgetList = widgetList;
    this.backgroundColor = backgroundColor;
    this.displayMessage = displayMessage;
    this.reviewbox = reviewbox;
    this.font = font;
    this.lineG = null;
    this.avgSingleBarGraph = null;
    this.map = null;
    this.hours = null;
    this.categories = "";
    this.opened_b = false;
    this.currentGraph = 2;
  }
  //constructor with no reviews dislay
  Screen(ArrayList <Button> widgetList, color backgroundColor, String displayMessage, PFont font)
  {
    this.graphs = new ArrayList();
    this.widgetList = widgetList;
    this.backgroundColor = backgroundColor;
    this.displayMessage = displayMessage;
    this.reviewbox = null;
    this.font = font;
    this.lineG = null;
    this.avgSingleBarGraph = null;
    this.map = null;
    this.hours = null;
    this.categories = "";
    this.opened_b = false;
    this.currentGraph = 2;
  }
  void setDisplayText(String text) {
    this.displayMessage = text;
  }
  void setBarGraph(BarGraph graph) {
    this.graphs.add(graph);
  }
  void clearBarGraph() {
    this.graphs.clear();
  }
  void setFocus(boolean focus) {
    this.focus = focus;
  }
  void draw()
  {
    background(backgroundColor);
    textFont(font, 20);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this.displayMessage +(this.displayMessage.equals("Error : no reviews to display!")?"":"explore "+ this.reviewbox.reviewsList.size() + ((this.reviewbox.reviewsList.size() > 1)?" reviews posted since ": " review posted on ") + convertStringToDate(getOldestReviewDate(reviewbox.reviewsList))+"."), width/3, 35) ;
    this.reviewbox.show();

    if (this.map != null) this.map.show();
    //printing extra information for the business if the business information is set.
    //displays this info ONLY if the current screent has been fed information relevant to a specific business (business screen).
    if (!this.categories.equals("") || this.hours != null) {
      fill(0);
      textAlign(LEFT, BOTTOM);;
      text("Type of business : \n"+this.categories, 200, 280);
      textAlign(CENTER, CENTER);
      if (opened_b) {
        fill(10, 240, 10);
        text("This business is opened ! ", 1580, 320);  
        fill(0);
        for (int i = 0; i < 7; i++) {
          fill(0);
          textSize(20);
          textAlign(LEFT, CENTER);
          text(DAYS[i], 1450, 350 + i * 30);  
          textAlign(RIGHT, CENTER);
          text((hours[i].equals("None"))?"closed":(hours[i]), 1700, 350 + i * 30);  
          fill(240, 10, 10);
        }
      } else {
        textSize(30);
        textAlign(CENTER,CENTER);
        fill(240, 10, 10);
        text("Business closed.", 1600, 450);
      }
      switch(currentGraph) {
      case 0:
        for (int i = 0; i < this.graphs.size() && this.graphs.get(i) != null; i++) this.graphs.get(i).draw();        
        break;
      case 1:
        if (this.lineG != null) this.lineG.draw();
        break;
      case 2:
        if (this.avgSingleBarGraph != null) this.avgSingleBarGraph.draw();        
        break;
      }
    } else {
      for (int i = 0; i < this.graphs.size() && this.graphs.get(i) != null; i++) this.graphs.get(i).draw();
      if (this.lineG != null) this.lineG.draw();
      if (this.avgSingleBarGraph != null) this.avgSingleBarGraph.draw();
    }
    for (int i =0; i < widgetList.size(); i++)
    {
      this.widgetList.get(i).show();
    }
  }
  void setSingleBarGraph(AvgStar graph) {
    this.avgSingleBarGraph = graph;
  }
  void setMessage(String text) {
    this.displayMessage = text;
  }
  void checkButtons() {
    focus = false;
    for (Button button : buttons) {
      int event = button.getEvent(mouseX, mouseY);
      boolean buttonFocus = false;                // represents whether the button was pressed by the user
      switch(event) {
      case EVENT_SORT_BY_STARS_DESCENDING:
        buttonFocus = true;
        if (!button.state) {
          button.state = true;
          sortByStars(this.reviewbox.reviewsList);
          this.reviewbox.loadDisplays();
          print("by stars!");
          if (reviewbox != null) {
            this.reviewbox.scrollBar.resetSpos();
          }
        } else {
          for (int i = 0; i < widgetList.size(); i++) {
            widgetList.get(i).state = false;
          }
          Collections.reverse(this.reviewbox.reviewsList);
          this.reviewbox.loadDisplays();
          this.reviewbox.scrollBar.resetSpos();
        }
        break;
      case EVENT_SORT_BY_NAME_ASCENDING:
        buttonFocus = true;
        if (!button.state) {
          button.state = true;
          sortByAuthorName(this.reviewbox.reviewsList);
          this.reviewbox.loadDisplays();
          print("by Name!");
          if (reviewbox != null) {
            this.reviewbox.scrollBar.resetSpos();
          }
        } else {
          for (int i = 0; i < widgetList.size(); i++) {
            widgetList.get(i).state = false;
          }
          Collections.reverse(this.reviewbox.reviewsList);
          this.reviewbox.loadDisplays();
          this.reviewbox.scrollBar.resetSpos();
        }

        break;
      case EVENT_SORT_BY_DATE_DESCENDING:
        buttonFocus = true;
        if (!button.state) {
          button.state = true;
          sortByMostRecentDate(this.reviewbox.reviewsList);
          this.reviewbox.loadDisplays();
          if (reviewbox != null) {
            this.reviewbox.scrollBar.resetSpos();
          }
        } else {
          for (int i = 0; i < widgetList.size(); i++) {
            widgetList.get(i).state = false;
          }
          Collections.reverse(this.reviewbox.reviewsList);
          this.reviewbox.loadDisplays();
          this.reviewbox.scrollBar.resetSpos();
        }
        break; 
      case EVENT_SEARCHBOX:
        println("search");
        focus = true;            // focus variable represents whether the current focus is on the search box
        buttonFocus = true;
        checkSearchBoxDisplayMessage();
        //button.setFocus(focus);
        break;
      case EVENT_EXIT:
        setCurrentScreenToUser(0);
        buttonFocus = true;
        println("off focus");
        break;
      case EVENT_SEARCH_ONCLICK:
        buttonFocus = true;
        focus = false;
        processSearch();
        println("clicked to search");
        break;

      case EVENT_GRAPH1:
        buttonFocus = true;
        this.currentGraph = 0;
        println("screen 0");
        break;
      case EVENT_GRAPH2:
        buttonFocus = true;
        println("screen 0");
        this.currentGraph = 1;
        break;
      case EVENT_GRAPH3:
        buttonFocus = true;
        println("screen 0");       
        this.currentGraph = 2;       
        break;
      }   
      button.setFocus(buttonFocus);
    }
  }

  void updateScrollBar(MouseEvent event) {
    if (reviewbox != null) {
      this.reviewbox.scrollBar.updateWheelScroll(event.getCount(), mouseX, mouseY, this.reviewbox.x, this.reviewbox.y, this.reviewbox.widgetWidth, this.reviewbox.widgetHeight);
    }
  }

  boolean getFocus() {
    return focus;
  }
  void setLineGraph(LineGraph graph) {
    this.lineG = graph;
  }
  void setMap(MapWidget map) {
    this.map = map;
  }
  void setBusinessInfo(String cat, boolean open, String []h) {
    this.hours = h;
    this.categories = cat;
    this.opened_b = open;
    println("set");
  }

  void setSwitchButton(Button [] array) {
    if (array != null && array.length > 0) {
      for (int i = 0; i < array.length; i++) {
        if (array[i] != null) this.widgetList.add(array[i]);
      }
    }
  }
}