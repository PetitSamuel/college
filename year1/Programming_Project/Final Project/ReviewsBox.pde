/*
  Author : Samuel Petit : creates a box which is given a list of reviews & displays/animates them using different objects & queries (such as the scrollbar object...).
*/

class reviewsBoxWidget extends Widget
{
  Scrollbar scrollBar;      
  ArrayList <reviewInstance> reviewsList;
  ArrayList<toDisplayReview> toShow;
  int indexOfFirstReviewToShow;
  PImage [] starImgs;
  PImage [] iconImgs;
  MySQL sql;
  reviewsBoxWidget(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, int widgetWidth, PFont font, ArrayList <reviewInstance> reviewsList, int scrollBarWidth, int sensibilityScrollBar, PImage [] stars, PImage [] icons, MySQL msql) 
  {
    super(x, y, widgetText, widgetColor, textColor, widgetHeight, widgetWidth, font);
    this.reviewsList = reviewsList;
    this.scrollBar = new Scrollbar(x + widgetWidth - scrollBarWidth, y, scrollBarWidth, widgetHeight, sensibilityScrollBar, this.reviewsList.size()); 
    this.toShow = new ArrayList();
    this.indexOfFirstReviewToShow = 0;
    this.starImgs = stars;
    this.iconImgs = icons;
    this.sql = msql;
    loadDisplays();
  }
  reviewsBoxWidget(int x, int y, String widgetText, color widgetColor, color textColor, int widgetHeight, int widgetWidth, PFont font, int scrollBarWidth, int sensibilityScrollBar, PImage [] stars, PImage [] icons, MySQL msql) 
  {
    super(x, y, widgetText, widgetColor, textColor, widgetHeight, widgetWidth, font);
    this.reviewsList = null;
    this.toShow = null;
    this.scrollBar = new Scrollbar(x + widgetWidth - scrollBarWidth, y, scrollBarWidth, widgetHeight, sensibilityScrollBar); 
    this.toShow = new ArrayList();
    this.indexOfFirstReviewToShow = 0;
    this.starImgs = stars;
    this.iconImgs = icons;  
    this.sql = msql;
  }

  void show() {
    noStroke();
    fill(widgetColor);
    rect(this.x, this.y, this.widgetWidth, this.widgetHeight);
    fill(this.textColor);
    textAlign(LEFT, TOP);
    textFont(this.font, 30);
    text(this.widgetText, this.x, this.y - 35, this.widgetWidth, this.widgetHeight);
    if (this.reviewsList != null) {
      this.scrollBar.update();
      this.scrollBar.show();
      //gets index of first review to display depending on the current position of the scroll bar widget.
      indexOfFirstReviewToShow = this.scrollBar.getIndexOfFirstReview(this.toShow.size());
      //sets the height of the reviews to be displayed for each review displayed & displays the next review until the current review goes below the widget height
      int newH = this.y;
      boolean outofpage = false;
      for (int i = this.indexOfFirstReviewToShow; i < toShow.size()&& i < reviewsList.size() && !outofpage; i++) {
        if (i < toShow.size() && i < reviewsList.size()) {
          toShow.get(i).setNewY(newH, getHeightString(this.reviewsList.get(i).getText()));
          newH += getHeightString(this.reviewsList.get(i).getText());
          if (newH < this.y + this.widgetHeight) {
            //queries for the extra information in order to be displayed (user names business names & such).
            checkForNonSetNames(i);
            toShow.get(i).show();
          } else {
            outofpage = true;
          }
        }
      }
    }
  }
  
  //sets the extra information not available by default in the review table into the 'review instance'.
  //will query for a given user id and business name for extra information : names, location, opening times, amounts of reviews etc.. (loads a couple in advance).
  void checkForNonSetNames(int index) {
    int minIndex = constrain(index - 5, 0, toShow.size());
    int maxIndex = constrain(index + 5, 0, toShow.size());
    int numberChanged = 0;
    for (int i = minIndex; i < maxIndex; i++) {
      if (toShow.get(i).review.getUser_name().equals("username") || toShow.get(i).review.getBusiness_name().equals("business name")) {
        sql.query("SELECT name, review_count FROM yelp_user WHERE user_id='"+ toShow.get(i).review.getUser_id() +"' LIMIT 1;");
        String u_name = "";
        int u_count = 0;
        while (sql.next()) {
          u_name = sql.getString("name");
          u_count = sql.getInt("review_count");
        }
        sql.query("SELECT name, address, city, state, latitude, longitude, review_count, categories, is_open FROM yelp_business WHERE business_id='"+ toShow.get(i).review.getBusiness_id() +"' LIMIT 1;");
         String b_categories = "";
         boolean b_open = false;  
         double longitude = 0.0;
         double latitude = 0.0;
         String state = "";
         String city = "";
         String address = "";        
        String b_name = "";
        int b_count = 0;
        while (sql.next()) {
          b_name = sql.getString("name");
          b_count = sql.getInt("review_count");
         b_categories = sql.getString("categories");
         b_open = sql.getBoolean("is_open");  
         longitude = sql.getDouble("longitude");
         latitude = sql.getDouble("latitude");
         state = sql.getString("state");
         city = sql.getString("city");
         address = sql.getString("address");         
        }
        reviewsList.get(i).setNames(u_name, b_name);
        reviewsList.get(i).setReviewsCount(u_count, b_count);
        reviewsList.get(i).setExtraInfo(b_categories, b_open, longitude, latitude, state, city, address);    
        toShow.get(i).updateReviewInstance(reviewsList.get(i));
        numberChanged++;
        if (numberChanged < 1 && i == maxIndex - 1) {
          maxIndex = constrain(maxIndex++, 0, toShow.size());
        }
      }
    }
  }
  //computes the height needed to show the full text review with a given font, font size, and widget width
  int getHeightString(String text) {
    int heightPerLine = fontHeight();
    int nbOfLines = numberOfLines(text);
    return (nbOfLines + 2) * heightPerLine+130;
  }
  
  //computes the amount of characters that fit into a set width, (with a given font and font size).  
  int charPerLine() {
    int fontw = fontWidth();
    return ceil(this.widgetWidth / fontw);
  }
  //computes the amount of lines a review will need to be entierely displayed (w/ a given font size and font).
  int numberOfLines(String text) {
    int nbCharPerLines = charPerLine();
    return ceil(text.length()/nbCharPerLines);
  }
  //returns the width of a single character with a set font/font size
  int fontWidth() {
    textFont(font, 15);
    return ceil(textWidth("  "));
  }
  //returns height of loaded font at a set text size
  int fontHeight() {
    textFont(font, 15);
    return ceil(textAscent() + textDescent());
  }
  
    //creates the toShow objects (reviews turned into formated displayable objects).
  void loadDisplays() {
    this.toShow = new ArrayList();
    for (int i = 0; i < this.reviewsList.size(); i++) {
      toDisplayReview reviewToShow = new toDisplayReview(this.x, this.y, this.widgetWidth - this.scrollBar.scrollWidth - 15, this.reviewsList.get(i), this.font, starImgs[this.reviewsList.get(i).getStars() - 1], iconImgs);
      this.toShow.add(reviewToShow);
    }
  }
  //to update reviews showing
  void setReviewsList(ArrayList <reviewInstance> reviewsList) {
    this.reviewsList = reviewsList;
    this.scrollBar.amountReviews = reviewsList.size();
    loadDisplays();
  }

  ArrayList<reviewInstance> getReviewsList() {
    return reviewsList;
  }
  
  //set the scrollbar sensitivity
  void setSensibility(int l) {
    this.scrollBar.sensibility = l;
  }
}