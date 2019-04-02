/*    @author : Petit Samuel (all but animation).  
Revisions:  
 *    29/03 J.C. animated the bar
 */

class AvgStar {
  int x, y, w, h;
  ReviewsStats rs;
  int amountReviews, txtSize;
  float avgStars;
  PFont font;
  float maxW;
  private float drawTimer;
  private float drawTime;
  private float drawSpeed;
  AvgStar(int x, int y, int w, int h, ReviewsStats rs, PFont font, int txtSize) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    this.rs = rs;
    this.amountReviews = rs.getNumberOfReviews();
    this.avgStars = (float)rs.getAverageStars();
    this.font = font;
    this.txtSize = txtSize;
    maxW = map(avgStars, 0, 5, 0, this.w);
    this.drawTimer = 0;
    this.drawTime = maxW;
    this.drawSpeed = drawTime/(frameRate*3);
  }
  void setReviewList(ReviewsStats rs) {
    this.rs = rs; 
    this.amountReviews = rs.getNumberOfReviews();
    this.avgStars = (float)rs.getAverageStars();
    maxW = map(avgStars, 0, 5, 0, this.w);
    this.drawTimer = 0;
    this.drawTime = maxW;
    this.drawSpeed = drawTime/(frameRate*3);
  }
  void draw() {
    fill(0);
    textFont(this.font, this.txtSize);  
    noStroke();
    textAlign(CENTER, CENTER);  
    text("Average ratings", this.x + this.w/2, this.y - this.h /2);
    //float maxW = map(avgStars, 0, 5, 0, this.w);
    stroke(0);
    fill(200);
    rect(this.x, this.y, this.w, this.h);
    fill(60, 125, 230);
    rect(this.x, this.y, drawTimer, this.h);
    if (drawTimer < drawTime) drawTimer+=drawSpeed;
    fill(0);
    text(rs.getNumberOfReviews() + " review" + (amountReviews==1?"":"s"), this.x + this.w +100, this.y+ this.h/2);
    fill(0);
    textAlign(CENTER, CENTER);  
    text(nf(this.avgStars, 0, 1), this.x + this.w/2, this.y + this.h /2);
  }

  void setDrawSpeed(float drawSpeed) {
    this.drawSpeed = drawSpeed;
  }

  void setDrawTimeAndSpeedInSeconds(float time) {          //in seconds
    this.drawTime = maxW;
    this.drawSpeed = drawTime/(frameRate*time);
  }

  void resetAnimation() {
    this.drawTimer = 0;
  }
}