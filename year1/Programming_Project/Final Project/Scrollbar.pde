/*
@author : Samuel Petit
    Inspired by a template in processing example's page (which was horizontal) & tuned to meet our requirements.

*/

class Scrollbar {
  int scrollWidth, scrollHeight;    // width and height of bar
  int xpos, ypos;       // x and y position of bar
  int spos, newspos;    // x position of slider
  int sposMin, sposMax; // max and min values of slider
  int sensibility;            
  boolean mouseOverEvent;
  int amountReviews;

  Scrollbar (int xPos, int yPos, int sWidth, int sHeight, int sensibility) {
    this.scrollWidth = sWidth;
    this.scrollHeight = sHeight;
    this.xpos = xPos;
    this.ypos = yPos;
    this.spos = yPos;
    this.newspos = spos;
    this.sposMin = yPos;
    this.sposMax = ypos +scrollHeight - scrollWidth;
    this.sensibility = sensibility;
    this.amountReviews = 0;
  }
  Scrollbar (int xPos, int yPos, int sWidth, int sHeight, int sensibility, int amountReviews) {
    this(xPos, yPos, sWidth, sHeight, sensibility);
    this.amountReviews = amountReviews;
  }
  void show() {
    noStroke();
    fill(235);
    //whole bar
    rect(xpos, ypos, scrollWidth, scrollHeight);
    //color for slider (if over scroll bar or not)
    if (overScrollBar(mouseX, mouseY) || mouseOverEvent) {
      fill(185);
    } else {
      fill(205);
    }
    //slider
    rect(xpos, spos, scrollWidth, scrollWidth);
  }

  //this method inspired by an example on the processing website
  void update() {
    if (overScrollBar(mouseX, mouseY)) {
      mouseOverEvent = true;
    } else {
      mouseOverEvent = false;
    }
    if (mousePressed && mouseOverEvent) {
      mouseOverEvent = true;
    }
    if (!mousePressed) {
      mouseOverEvent = false;
    }
    if (mouseOverEvent) {
      //converting 
      newspos =(int) constrain(mouseY-scrollWidth/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/sensibility;
    }
  }

  //converts value of the current slider position within its max/min values to the 1 index position of reviews to display
  int getIndexOfFirstReview(int maxIndex) {
    return (int) map(this.spos, this.sposMin, this.sposMax, 0, maxIndex-1);
  }

  boolean overScrollBar(int mX, int mY) {
    if (mX > this.xpos && mX < this.xpos+this.scrollWidth &&
      mY > this.ypos && mY < this.ypos+this.scrollHeight) {
      return true;
    } else {
      return false;
    }
  }
  void updateWheelScroll(int quantity, int mX, int mY, int x, int y, int w, int h) {
    if (overReviewPage(mX, mY, x, y, w, h)) {
      if (quantity < 0) {
        
        spos =constrain(spos-1, sposMin, sposMax);
        newspos = spos;
      } else if (quantity > 0) {
        spos =constrain(spos+1, sposMin, sposMax);
        newspos = spos;
      }
    }
  }
  boolean overReviewPage(int mX, int mY, int x, int y, int w, int h) {
    if (mX > x && mX < x  + w && mY > y && mY <y + h) {
      return true;
    } else {
      return false;
    }
  }

  void resetSpos() {
    this.spos = this.sposMin; 
    this.newspos = spos;
  }
}