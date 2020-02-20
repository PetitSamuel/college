/*  Revisions: //<>// //<>// //<>// //<>// //<>//
 *            ...
 *            01/04 11:30 J.Cistiakovas - changed search box to search globally rather than locallly
 *                  12:00 J.Cistiakovas - added a function to load reviews without clearing the ones stored already. Changed processSearch() to work with that. Now the reviews of more than 1 business
 *                                        can be outputted from the search.
 
           Petit Samuel  :   In charge of (in the main line):
                       - putting the different classes and objects (screens, buttons etc) together
                       - creating sql server/uploading data to it (+ making sure to index certain fields for queries efficiency.
                       - optimized queries (by adding keys in sql database) & adding ordering by relevance/match to the input when searching for a name (also added search by name for users : use "user xxx" to search for user names)
                      
 */
 //libraries required : unfolding maps. bezierSQLib
//map related imports. The library is included in the "data" folder of this program. Please install it before running this program.
import de.fhpotsdam.unfolding.*; //<>// //<>// //<>// //<>// //<>// //<>//
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;
import de.bezier.data.sql.*; //<>// //<>// //<>//


//mysql object
MySQL msql, msql2;

//lists 
ArrayList <reviewInstance> reviewsList;
HashMap<String, ReviewsStats> reviewers;
HashMap<String, ReviewsStats> businesses;
ArrayList<Button> buttons;

//fonts and images
PFont fontForTextDisplay;
PImage [] starImgs;
PImage [] iconImages;

//class objects
reviewsBoxWidget homePageWidget, userXWidget;
Screen homePageScreen, userScreen, buisnessScreen;
searchWidget searchBox;
Button sortByDescendingRatingButton, sortByAscendingNameButton, sortByAscendingDateButton, executeSearch;
LineGraph lg;
AvgStar averageGraph;
Screen currentPage;
MapWidget map;

//variables
int currentScreen;


void setup() {
  //initialising arrays
  buttons = new ArrayList<Button>();
  businesses = new HashMap<String, ReviewsStats>();
  reviewers = new HashMap<String, ReviewsStats>();
  println("trying to connect to the server");
  //connecting to sql server
  msql = new MySQL( this, HOST, DATABASE, USER, PASSWORD);
  msql.connect();
  msql2 = new MySQL( this, HOST, DATABASE, USER, PASSWORD);
  msql2.connect();  

  if ( msql.connect() && msql2.connect())
  {
    println( "CONNECTED");
  }
  //loading original reviews : first 100 reviews
  load_reviews_from_query("SELECT * FROM " + "yelp_review" + " LIMIT 0, 100;");     
  println("found reviews");
  
  //loading images (used for displaying reviews : star images and incon images)
  iconImages = new PImage []{loadImage("cool.png"), loadImage("funny.png"), loadImage("useful.png")};
  starImgs = new PImage [] {loadImage("star1.png"), loadImage("star2.png"), loadImage("star3.png"), loadImage("star4.png"), loadImage("star5.png")} ;

  //loading text font
  fontForTextDisplay  = loadFont("Rockwell-48.vlw");
  textFont(fontForTextDisplay);

  currentScreen = 0;

  //creating reviewboxes (widget which display reviews, includes a scrollbar & a list of reviews to display).
  homePageWidget = new reviewsBoxWidget(150, 400, "Review Box", color(255), color(0), Ypos - 500, Xpos - 250, fontForTextDisplay, reviewsList, 17, 15, starImgs, iconImages, msql2);
  userXWidget = new reviewsBoxWidget(80, 500, "Review Box", color(255), color(0), Ypos -600, Xpos - 850, fontForTextDisplay, 17, 15, starImgs, iconImages, msql2);

  //creating all buttons & lists of buttons for different screens
  sortByDescendingRatingButton = new Button(500, 350, "Sort by Stars!", color(100), color(240), 50, 150, fontForTextDisplay, EVENT_SORT_BY_STARS_DESCENDING);
  sortByAscendingNameButton = new Button(1000, 350, "Sort by Name(A-Z)!", color(100), color(240), 50, 150, fontForTextDisplay, EVENT_SORT_BY_NAME_ASCENDING);
  sortByAscendingDateButton = new Button(1500, 350, "Sort by Date(new-old)!", color(100), color(240), 50, 150, fontForTextDisplay, EVENT_SORT_BY_DATE_DESCENDING);
  searchBox=new searchWidget(200, 100, 1500, 40, DEFAULT_SEARCH_PROMPT, color(245), color(150), fontForTextDisplay, EVENT_SEARCHBOX, 50);  
  Button exitButton = new Button(width - 50, 0, "X", color(220, 10, 20), color(255), 50, 50, fontForTextDisplay, EVENT_EXIT);  
  executeSearch = new Button(searchBox.x + searchBox.widgetWidth + 1, searchBox.y, "Find!", color(50, 205, 50), color(0), searchBox.widgetHeight + 2, 80, fontForTextDisplay, EVENT_SEARCH_ONCLICK);
  Button toGraphOne = new BarGraphButton(1300, 950, "1", color(102, 153, 255), color(255), 50, 100, fontForTextDisplay, EVENT_GRAPH1);  
  Button toGraphTwo = new LineGraphButton(1500, 950, "2", color(102, 153, 255), color(255), 50, 100, fontForTextDisplay, EVENT_GRAPH2);  
  Button toGraphThree = new AverageButton(1700, 950, "3", color(102, 153, 255), color(255), 50, 100, fontForTextDisplay, EVENT_GRAPH3); 
  buttons.add(sortByDescendingRatingButton);
  buttons.add(sortByAscendingNameButton);
  buttons.add(sortByAscendingDateButton);
  buttons.add(executeSearch); 
  buttons.add(exitButton);
  buttons.add(searchBox);
  buttons.add(toGraphOne);
  buttons.add(toGraphTwo);
  buttons.add(toGraphThree);

//removing some buttons for some screens (not all screen have the same list of widgets, some have more than others).
  ArrayList <Button> buttonsHome = new ArrayList(buttons);
  buttonsHome.remove(8);
  buttonsHome.remove(7);
  buttonsHome.remove(6);
  buttonsHome.remove(4);
  ArrayList <Button> buttonsUser = new ArrayList(buttons);
  buttonsUser.remove(8);
  buttonsUser.remove(7);
  buttonsUser.remove(6);

  //creating screens & graphs
  homePageScreen = new Screen(buttonsHome, homePageWidget, color(255), "Welcome, ", fontForTextDisplay);  
  userScreen = new Screen(buttonsUser, userXWidget, color(255), "", fontForTextDisplay);
  buisnessScreen = new Screen(buttons, userXWidget, color(255), "", fontForTextDisplay);
  currentPage = homePageScreen;

// 3 graphs used within our program. They are created/added to the screen as the user makes an event that will take him to a new screen.
  averageGraph = null;
  lg = null;
  map = null;
}
void settings() {
  size(Xpos, Ypos, P2D);
}

void draw() {
  background(255);
  //drawing screens
  switch(currentScreen) {
  case 0:
    homePageScreen.draw();
    break;
  case 1:
    userScreen.draw();
    break;    
  default:
    buisnessScreen.draw();
    break;
  }
}
//clears review list before loading new reviews from a query
void load_reviews_from_query(String query) {
  reviewsList = new ArrayList();  
  load_reviews_from_query_no_clear(query);
}

//loads reviews from a given query & adds the created object (review instance) for each result to a list
void load_reviews_from_query_no_clear(String query) {
  msql.query(query);
  println("found reviews");  
  while (msql.next()) {
    String u_id = msql.getString("user_id");
    String b_id = msql.getString("business_id");
    int stars = msql.getInt("stars");
    String date = msql.getString("date");
    String text = msql.getString("text");
    int useful = msql.getInt("useful");
    int funny = msql.getInt("funny");
    int cool = msql.getInt("cool");
    reviewInstance review = new reviewInstance(u_id, b_id, text, date, stars, useful, funny, cool);
    reviewsList.add(review);
  }
}

//to update the scrollbar when the mouse wheel is used.
void mouseWheel(MouseEvent event) { 
  switch(currentScreen) {
  case 0:
    homePageScreen.updateScrollBar(event);
    break;
  case 1:
    userScreen.updateScrollBar(event);
    break;
  default:
    buisnessScreen.updateScrollBar(event);
    break;
  }
}

//checks if a button has been pressed when a mouse click is detected (checks through the list of buttons the current screen has).
void mousePressed() {
  searchBox.setSuggestionClicked(mouseX, mouseY);    // at the moment it is called each tome mouse is Pressed. TODO: move to screen class?
  switch(currentScreen) {
  case 0:
    homePageScreen.checkButtons();
    break;
  case 1:
    userScreen.checkButtons();
    break;
  default:
    buisnessScreen.checkButtons();
    break;
  }
}

//to switch to the home page screen.
public void setCurrentScreenToUser(int event) {
  currentPage = homePageScreen;  
  currentScreen = event;
  setButtonsPos(0);
  searchBox.setWidth(SEARCHBOX_WIDTH);
  searchBox.x = 200;  
  executeSearch.x = searchBox.x + searchBox.widgetWidth;  
  searchBox.widgetText = "search in here.";
}

//to switch to a business or users page (when clicking on a specific user or business name : gets a the review instance the user clicked on & the event (wether it is switching to a user or business screen)).
public void setCurrentScreenToX(int event, reviewInstance review) {  
  //switch current screen
  currentScreen = event;
  if (event == 1) {
    currentPage = userScreen;
  } else if (event == 2) {
    currentPage = buisnessScreen;
  }
  //changing positions of "ordering" buttons
  setButtonsPos(1);
  //loading query (depending on the event)
  String query = "";
  if (event == 1) {
    currentPage.setDisplayText(review.getUser_name()+"'s reviews, ");
    query = "SELECT * FROM yelp_review WHERE user_id= '"+review.getUser_id()+"'LIMIT "+review.getU_reviews_count()+";";
  } else if (event == 2) {
    currentPage.setDisplayText(review.getBusiness_name()+"'s reviews, ");
    query = "SELECT * FROM yelp_review where business_id='"+ review.getBusiness_id() +"' LIMIT "+ review.getB_reviews_count() + ";";
  }
  println(query);
  //loading new reviews
  load_reviews_from_query(query);
//setting new returned review list to the screen to be displayed
  currentPage.reviewbox.setReviewsList(reviewsList);
  //clearing current graphs
  currentPage.clearBarGraph();
  BarGraph screenOfXGraph1 = null;
  ReviewsStats rs = null;
  //creating new review stat instance : useful for graphs
  if (event == 1) {
    rs = new ReviewsStats(review.getUser_name(), review.getUser_id(), reviewsList);
  } else {
    rs = new ReviewsStats(review.getBusiness_name(), review.getBusiness_id(), reviewsList);
  }
  ArrayList<ArrayList<Integer>> years = rs.getYearChangeStats(10, 1);
  //creating and setting new graphs to screen (again, depends on the event : to fit the size & format of a user or business page)
  if (event == 1) {
    screenOfXGraph1 = new BarGraph(100, 75, 5, 500, 500, 50, 20, 30, rs, color(200, 200, 100), "Stars", "percentage", userXWidget.x + userXWidget.widgetWidth + 150, 900, fontForTextDisplay);
    lg = new LineGraph(userXWidget.x + userXWidget.widgetWidth + 180, 100, 400, 150, years, fontForTextDisplay, 10, 1);
    averageGraph = new AvgStar(500, 250, 200, 30, rs, fontForTextDisplay, 20);
  } else if (event == 2) {
    screenOfXGraph1 = new BarGraph(100, 75, 5, 275, 400, 25, 20, 30, rs, color(200, 200, 100), "Stars", "percentage", 1400, 855, fontForTextDisplay);  
    lg = new LineGraph(1350, 650, 400, 180, years, fontForTextDisplay, 10, 1);
    averageGraph = new AvgStar(1325, 750, 350, 80, rs, fontForTextDisplay, 20);
  }
  //setting new graphs & widgets to fit new screen
  currentPage.setBarGraph(screenOfXGraph1);
  lg.setxLabel("years");
  lg.setyLabel("Average Stars");
  currentPage.setLineGraph(lg);
  searchBox.setWidth(SET_WIDTH);   
  searchBox.x = 80;
  executeSearch.x = searchBox.x + searchBox.widgetWidth;    
  averageGraph.setReviewList(rs);
  currentPage.setSingleBarGraph(averageGraph);
  currentPage.reviewbox.scrollBar.resetSpos();  
  
  //creates a map & sets it to the screen only if the screen to be displayed is a business page (& has location information)
  //also sets extra business information such as : opening times, categories...
  if (event == 2) {
    map = new MapWidget(this, 1500, 35, 200, 200, (review.getBusiness_name() + ", " + review.getAddress()), color(20), color(20), fontForTextDisplay, EVENT_NULL, (float)review.getLatitude(), (float)review.getLongitude()); 
    currentPage.setMap(map);
    review.setHours(queryHours(review));
    currentPage.setBusinessInfo(review.getB_categories(), review.isB_open(), review.getHours());
  }
}
//returns the business opening hours from a given review instance (done by quering the business_hours table)
String [] queryHours(reviewInstance review) {
  msql.query("SELECT * FROM yelp_business_hours WHERE business_id= '" + review.getBusiness_id()+ "' LIMIT 1;");
  println("found business hours");
  String [] hours = new String [7];
  while (msql.next()) {
    hours[0] = msql.getString("monday");
    hours[1] = msql.getString("tuesday");
    hours[2] = msql.getString("wednesday");
    hours[3] = msql.getString("thursday");
    hours[4] = msql.getString("friday");
    hours[5] = msql.getString("saturday");
    hours[6] = msql.getString("sunday");
  }
  for (int i = 0; i < 7; i++) {
    println(hours[i]);
  }
  return hours;
}
//updates search bar when a key is pressed (or exits the program if 'esc' is pressed)
void keyPressed()
{

  if (currentPage != null && currentPage.getFocus()) {    // J.C. - added check for focus back, so to make sure that letters are appended only when search box is in focus
    if (key == ENTER)
    {
      processSearch();
    } else
    {
      searchBox.append(key);
    }
    if (searchBox.getText().length() >=1) {
      showSuggestedSearch();
    } else {
      searchBox.clearSuggestions();
    }
  }

  if (key == ESC) {    // if ESCAPE is pressed, the program will be stopped
    exit();
  }
}

//gets business suggestions from a given text input (in the search bar).
void showSuggestedSearch() {
  //ArrayList<String> suggestions = getSuggestionsStrings(searchBox.getText(), reviewsList);
  ArrayList<String> suggestions = getSuggestionsBusiness(searchBox.getText().trim().toLowerCase(), msql2);
  searchBox.setSuggestions(suggestions);
}

//processes a search by business/user name (which uses the search bar widget. Is executed when "enter" 
void processSearch() {
  reviewsList.clear();      // clear the reviews from the box before gathering new ones
  searchBox.setFocus(false);
  //gets input text, sets screen to home page & checks if the first 4 characters are 'user'.
  String input = searchBox.getText().trim() ;
  setCurrentScreenToUser(0);
  currentPage = homePageScreen;
  boolean user = false;
  if(input.length() >=4){
    if(input.substring(0, 4).toLowerCase().equals("user")){
      user = true;
      input = input.substring(5);
    }
  }
  
  if (input.length() == 0) {    // if search field is empty, then just load in 100 random reviews
    load_reviews_from_query("SELECT * FROM " + "yelp_review" + " LIMIT 1, 100;");
    currentPage.reviewbox.setReviewsList(reviewsList);
    //if the user has not entered the 'user' keyword, search for businesses
  } else if(!user) {
    //String query = "SELECT user_id, review_count FROM yelp_user WHERE name = '" + name+"' LIMIT 1;";
    String query = "SELECT business_id, review_count FROM yelp_business WHERE name LIKE '" + input + "%'  ORDER BY name = '" + input + "' DESC, name LIKE '" + input + "%' DESC LIMIT 200;";
    println(query);
    msql2.query(query);
    String u_Id = "";
    int reviewCount = 0;
    //loads reviews from each business returned
    while (msql2.next() && reviewsList.size() <= 250) { 
      u_Id = msql2.getString("business_id");
      reviewCount = msql2.getInt("review_count");
      int limit = reviewCount;
      query = "SELECT * FROM yelp_review where business_id='"+ u_Id +"' LIMIT "+limit+" ;";
      println(query);
      load_reviews_from_query_no_clear(query);
    }
    //sets screen reviews list to the new and updated one.
    currentPage.reviewbox.setReviewsList(reviewsList);
    //otherwise, search for users, same procedure as above.
  } else {
      //String query = "SELECT user_id, review_count FROM yelp_user WHERE name = '" + name+"' LIMIT 1;";
      String query = "SELECT user_id, review_count FROM yelp_user WHERE name LIKE '" + input + "%'  ORDER BY name = '" + input + "' DESC, name LIKE '" + input + "%' DESC LIMIT 200;";
      println(query);
      msql2.query(query);
      String u_Id = "";
      int reviewCount = 0;
      while (msql2.next() && reviewsList.size() <= 100) {    // search for exact mathces
        u_Id = msql2.getString("user_id");
        reviewCount = msql2.getInt("review_count");
        query = "SELECT * FROM yelp_review where user_id='"+ u_Id +"' LIMIT "+reviewCount+" ;";
        println(query);
        load_reviews_from_query_no_clear(query);
      }
    currentPage.reviewbox.setReviewsList(reviewsList);      
  }

  // adjusting the page title (setting the first char to be uppercase, & error checking).
  if (currentPage.reviewbox.reviewsList.size() == 0) {
    currentPage.setMessage("Error : no reviews to display!");
  } else if (input.length() != 0) {
    if (searchBox.getText().length() > 1) {
      String nameUpcase = input.toUpperCase();
      String name = input.substring(1).toLowerCase();
      name = nameUpcase.charAt(0) + name;
      currentPage.setMessage(name+ "'s reviews, ");
    }
  } else if (input.length() == 0) {
    currentPage.setMessage("Welcome, ");
  }
  //sets new name & resets scrollbar position to initial position.
  currentPage.reviewbox.scrollBar.resetSpos();
  searchBox.setWidgetText(input);
}

//method to switch buttons positions : 2 different positions, one for home page & another one for users and business page. The same buttons 
//are used in all screens, their position is just changed.
void setButtonsPos(int pos) {
  if (pos == 1) {
    sortByDescendingRatingButton.setPos(100, 400);
    sortByAscendingNameButton.setPos(550, 400);
    sortByAscendingDateButton.setPos(980, 400);
  } else {
    sortByDescendingRatingButton.setPos(500, 350);
    sortByAscendingNameButton.setPos(SET_WIDTH, 350);
    sortByAscendingDateButton.setPos(SEARCHBOX_WIDTH, 350);
  }
}