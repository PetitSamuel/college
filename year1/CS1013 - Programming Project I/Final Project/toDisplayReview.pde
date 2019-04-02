/*
Author : Samuel Petit : 
    gets a review instance & formats it to show all of the infrmation relevant to displaying a review

*/

import java.text.SimpleDateFormat;
class toDisplayReview {
  int x, y, w, h, stars;
  String reviewDate, reviewText;
  int []iconsValues;
  PFont font;
  PImage starsImage;
  PImage [] icons;
  color textColor, buisnessColor, showAllColor;
  final color overText = color(10, 50, 200);
  int bnameWidth;
  reviewInstance review;
  toDisplayReview(int x, int y, int w, reviewInstance review, PFont font, PImage starImage, PImage [] icons) {
    this.review = review;
    this.textColor = color(0);
    this.buisnessColor = color(0);
    this.showAllColor = color(0);
    this.bnameWidth = 0;
    this.x = x;
    this.y = y;
    this.w = w;
    this.stars = review.getStars();
    this.reviewText = review.text.replace("\n", "").replace("\r", "");
    this. h =0;
    this.reviewDate = convertStringToDateWithYear(review.getDate());
    this.font = font;
    this.starsImage = starImage;
    this.icons = icons;
    this.iconsValues = new int[]{review.cool, review.funny, review.useful};

  }
  void show() {
    fill(0);
    textFont(font, 15);
    text(this.reviewText, this.x + 10, this.y + 80, this.w, this.h);
    text(this.reviewDate, this.x + 200, this.y + 30);

    textFont(font, 18);
    fill(this.textColor);
      text(this.review.getUser_name(), this.x + 40, this.y + 30);
    fill(this.buisnessColor);
    text(this.review.getBusiness_name(), this.x + 350, this.y + 30); 
    bnameWidth = (int) textWidth(this.review.getBusiness_name());
    textFont(font, 14);
    fill(this.showAllColor);
    // text("show all for this buisness", this.x + 400 + bnameWidth, this.y + 30);  
    starsImage.resize(120, 30);
    image(starsImage, this.x + 40, this.y + 40);
    update();
    int tmpx = 0;
    textFont(font, 20);  
    fill(0);
    for (int i = 0; i < 3; i++) {
      icons[i].resize(35, 35);
      image(icons[i], this.x + tmpx + 10, this.y + this.h -40); 
      text(iconsValues[i], this.x + tmpx + 20 + icons[i].width, this.y + this.h - 28);
      tmpx += icons[i].width + 200;
    }
}

  void update() {
    boolean overUser = false;
    boolean overBuisness = false;
    boolean overShowAll = false;
    if (overUserText(mouseX, mouseY)) {
      overUser = true;
      this.textColor = overText;
    } else {
      this.textColor = color(0);
    }
    if (overBuisnessText(mouseX, mouseY)) {
      overBuisness = true;
      this.buisnessColor = overText;
    } else {
      this.buisnessColor = color(0);
    }
    /*
    if (overshowAllText(mouseX, mouseY)) {
     overShowAll = true;
     this.showAllColor = overText;
     } else {
     this.showAllColor = color(0);
     }
     */
    if (mousePressed && overUser) {
      setCurrentScreenToX(1, this.review);
      //      cardholderDataRecords.addAll(transitionHash.values());
    } else if (mousePressed && overBuisness) {
      setCurrentScreenToX(2, this.review);
    }
    //    else if(mousePressed && overShowAll){
    //      setCurrentScreenToX(2, this.b_id, this.buisnessName);            
    //    }
  }
  boolean overUserText(int mX, int mY) {
    if (mX>this.x + 40 && mX < this.x + 40 + textWidth(this.review.getUser_name()) && mY >this.y + 30 && mY <this.y+ 30 + heightfont(18)) {
      return true;
    } else {
      return false;
    }
  }
  boolean overBuisnessText(int mX, int mY) {
    if (mX>this.x + 350 && mX < this.x + 350 + textWidth(this.review.getBusiness_name()) && mY >this.y + 30 && mY <this.y+ 30 + heightfont(18)) {
      return true;
    } else {
      return false;
    }
  }
  //  text("show all for this buisness", this.x + 400 + bnameWidth, this.y + 30);  

  boolean overshowAllText(int mX, int mY) {
    if (mX>this.x + 400 + this.bnameWidth && mX < this.x + 400 + this.bnameWidth + textWidth("show all for this buisness") && mY >this.y + 30 && mY <this.y+ 30 + heightfont(12)) {
      return true;
    } else {
      return false;
    }
  }
  int heightfont(int size) {
    textFont(font, size);
    return ceil(textAscent() + textDescent());
  }
  void setNewY(int y, int h) {
    this.h = h;
    this.y = y;
  }

  void updateReviewInstance(reviewInstance ri){
   this.review = ri; 
  }
}