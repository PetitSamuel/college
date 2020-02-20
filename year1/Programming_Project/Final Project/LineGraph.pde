
// @author Jevgenijus Cistiakovas 14/03 22:00
// LineGraph class represents a 2-d line graph. A graph with x and y axes, with multiple points with adjacent points connected by a line. 
// LineGraph can be used to represents trenads over time;
//
//
// J.Cistiakovas 15/03 created the LineGraph class and added all the basic fucntions.
// J.C  19/03 added some dynamic fucntionality to graph. When a user hovers over a point, a small prompt rectangle is displayed with coordinates of the point.
//            Lines are drawn from the point to the axes.
// J.C. 25/03 added some null-pointer checks
//  for test put in main and call lg.draw() in the draw function
//  put in setup():
//    ReviewsStats statsFull = new ReviewsStats("","",reviewsList);
//    ArrayList<ArrayList<Integer>> years = statsFull.getYearChangeStats(10,1);
//    lg = new LineGraph(100,100,300,400, years, fontForTextDisplay,10,1);

class LineGraph {
  private final int xpos;
  private final int ypos;
  private final int width;
  private final int height;
  private ArrayList<ArrayList<Integer>> data;
  private ArrayList<ArrayList<Integer>> points;
  private ArrayList<ArrayList<String>> pointLabels;
  private String xLabel;
  private String yLabel;
  private boolean showXAxis;
  private boolean showYAxis;
  private int minY = Integer.MAX_VALUE;
  private int maxY = -1;
  private int minX = Integer.MAX_VALUE;
  private int maxX = -1;
  private color pointColour;
  private color lineColour;
  private color mainColour;
  private color backgroundColour;
  private int lineWidth;
  private int pointSize;
  private PFont font;
  private int margin;
  private int scaleX;          // we will need to downscale the value labels by this factor. It is used to preserve some accuracy. e.g. with scaleX = 10, point 3.5 will be stored as 35
  private int scaleY;
  private boolean toDrawBorder;
  private int mode;
  private float drawTimer;
  private float drawTime;
  private float drawSpeed;
  private final int AVERAGE_STARS_VS_YEARS = 1;

  // data must represent points with corresponding 2 coordinates, where data[i][0] = x-coordinate and data[i][1] = y- coordinate
  LineGraph(int xpos, int ypos, int width, int height, ArrayList<ArrayList<Integer>> data, PFont font, int scaleX, int scaleY) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.width = width;
    this.height = height;
    this.data = data;
    this.font = font;
    this.xLabel = "";
    this.yLabel = "";
    this.pointColour = color(0);
    this.lineColour = color(50);
    this.mainColour = color(0);
    this.backgroundColour = color(255);
    this.lineWidth = 2;
    this.pointSize = 5;
    this.margin = 0;
    this.scaleX = scaleX;
    this.scaleY = scaleY;
    this.toDrawBorder= false;
    this.mode = AVERAGE_STARS_VS_YEARS;
    this.drawTimer = 0;
    this.drawTime = data.size();
    this.drawSpeed = drawTime/(frameRate*3);
    setMaximums();
    mapPoints();
  }

  void draw() {
    noStroke();
    fill(backgroundColour);
    rect(xpos, ypos, width, height);
    fill(mainColour);
    if (toDrawBorder) {
      noFill();
      rect(xpos, ypos, width, height);
    }
    //axes
    fill(mainColour);
    stroke(1);
    line(xpos + margin, ypos + margin, xpos +margin, ypos +height - margin);      //y-axis
    line(xpos + margin, ypos + height - margin, xpos + width - margin, ypos + height - margin);      //x-axis
    if(drawTimer < drawTime){
      drawTimer += drawSpeed;
    }
    drawPoints();
    float[] separations = drawPointLabels();
    drawLabels(separations);
    if (drawTimer >= drawTime) {
      drawPrompt(mouseX, mouseY);
    }
  }

  // draws a rectangular prompt window, displaying the accurate coordinates of the point
  void drawPrompt(int mX, int mY) {
    for (int i = 0; i < points.size(); i++) {
      int oX = xpos + margin;            // x-coordinate of origin
      int oY = ypos + height - margin;    // y-coordinate of origin
      int x = oX + points.get(i).get(0);
      int y = oY - points.get(i).get(1);
      if ( mX > x - pointSize && mX < x + pointSize && mY > y - pointSize && mY < y+pointSize) {
        int promptWidth = 100;
        int promptHeight = 30;
        fill(100, 100, 100, 200);
        int xOffset = 0; 
        int yOffset = 0;
        if (mX + promptWidth > Xpos) {
          xOffset = -1 * int(promptWidth * 1.25);
        }
        if (mY + promptHeight > Ypos) {
          yOffset = -1 * int(promptHeight * 1.25);
        }
        rect(mX + xOffset, mY + yOffset, promptWidth, promptHeight);
        textFont(font, 15);      // hardcoded font-size and colours TODO: make it more maintainable
        fill(255);
        int year = data.get(i).get(0);
        double averageStars = (double)data.get(i).get(1) / (double)scaleX;
        String prompt = "(" + year + " ; " + averageStars + ")";
        text(prompt, mX, mY, promptWidth, promptHeight);
        //draw dashed lines to axes?
        stroke(1);
        fill(lineColour);
        line(x, y, oX, y); //line to y-axis
        line(x, y, x, oY); //line to x-axis
      }
    }
  }



  //draws the points on the plane
  private void drawPoints() {
    if (points.size() > 0) {
      int oX = xpos + margin;            // x-coordinate of origin
      int oY = ypos + height - margin;    // y-coordinate of origin
      int nextPointX = oX + points.get(0).get(0);
      int nextPointY = oY - points.get(0).get(1);
      int xCoordinate;
      int yCoordinate;
      for (int i = 0; i < points.size(); i++) {
        xCoordinate = nextPointX;
        yCoordinate = nextPointY;
        if (i < points.size() - 1) {
          nextPointX = oX + points.get(i+1).get(0);
          nextPointY = oY - points.get(i+1).get(1);
          if (drawTimer > i) {
            fill(pointColour);
            ellipse(xCoordinate, yCoordinate, pointSize, pointSize);
            if (drawTimer < i +1) {
              float slope = (float)(nextPointY - yCoordinate) / (float)(nextPointX - xCoordinate);
              float dx= nextPointX - xCoordinate;
              float dy = nextPointY - yCoordinate;
              fill(lineColour);
              stroke(lineWidth);
              //line(xCoordinate, yCoordinate, nextPointX, nextPointY);
              line(xCoordinate, yCoordinate, xCoordinate + (drawTimer-i)*dx, yCoordinate + (drawTimer-i)*dy);
            } else {
              line(xCoordinate, yCoordinate, nextPointX, nextPointY);
            }
          } else {
            //line(xCoordinate, yCoordinate, nextPointX, nextPointY);
          }
        } else if (drawTimer >= drawTime) {
          fill(pointColour);
          ellipse(xCoordinate, yCoordinate, pointSize, pointSize);
        }
      }
    }
  }

  // draws the axis labels if they are set
  private void drawLabels(float[] separations) {
    if (xLabel != null) {
      textFont(font, 20);    //harcoded font size
      text(xLabel, xpos + margin + width/2, ypos + height - margin + 2*textAscent() + 2*separations[0]);
    }
    if (yLabel != null) {
      float x = xpos + margin/2 - textAscent() -  + 1.25*separations[1];
      float y = ypos + height/2;
      pushMatrix();
      translate(x, y);
      rotate(-HALF_PI);
      text(yLabel, 0, 0);
      popMatrix();
    }
  }

  // generates coordinates of the points passed in data
  private void mapPoints() {
    points = new ArrayList<ArrayList<Integer>>();
    for (int i = 0; i < data.size(); i++) {
      points.add(new ArrayList<Integer>());
      points.get(i).add(int(map(data.get(i).get(0), minX, maxX, 0, this.width-2*margin)));
      int maxInputX = 1;      // else create a function or setter to define max value in an input set
      int minInputX = 0;
      if (mode == AVERAGE_STARS_VS_YEARS) {
        maxInputX = 5;
        minInputX = 0;
      }
      points.get(i).add(int(map(data.get(i).get(1), minInputX, maxInputX*scaleX, 0, height-2*margin)));
    }
  }

  // draws the axis scale. CUrrently only works for average stars case.
  private float[] drawPointLabels() {
    //Specific case for average stars
    textFont(font, 15);
    float[] margins = new float[2];
    // x-axis marking
    for (int i = 0; i < points.size(); i++) {
      textAlign(CENTER, BOTTOM);
      float notchX = xpos + margin + points.get(i).get(0);
      float notchY = ypos + height - margin;
      float x = notchX + textAscent();      // x- coordinate
      float ySeparation = 0;
      if (mode == AVERAGE_STARS_VS_YEARS) {
        ySeparation = textWidth(Integer.toString(i+2007));
      } else {
        ySeparation = textWidth(Integer.toString(i));      //or any other default behaviour
      }
      margins[1] = ySeparation;
      float y = notchY+ ySeparation;
      line(notchX, notchY, notchX, notchY + 5); 
      pushMatrix();
      translate(x, y);
      rotate(-HALF_PI);
      if (mode == AVERAGE_STARS_VS_YEARS) {
        text(i+2007, 0, 0);
      } else {
        text(i, 0, 0);      //or any other default
      }
      popMatrix();
    }

    //y -axis labels
    for (int i = 0; i <= 10; i++) {          // 10 is the number of notches on y-axis
      textAlign(CENTER, CENTER);
      double label = (double)i/2.0;
      float notchX = xpos + margin;
      float notchY = ypos + height - margin - (height-2*margin)*i/10;
      line(notchX, notchY, notchX - 5, notchY); 
      float textWidth = textWidth(Double.toString(label));
      margins[0] = textWidth;
      float x = notchX - textWidth;      // x- coordinate
      text(Double.toString(label), x, notchY);
    }
    return margins;
  }

  //finds the minimums and maximums and sets them. Required for futher mapping of points to coordinates
  void setMaximums() {
    for (int i = 0; i < data.size(); i++) {
      int x = data.get(i).get(0);
      int y = data.get(i).get(1);
      if (x > maxX) maxX = x;
      if (y > maxY) maxY= y;
      if (x < minX) minX = x;
      if (y < minY) minY = y;
    }
  }

  //Getters and setters. Less important options are put outside of constructor

  void setMode(int mode) {      //potentially might break the program
    this.mode = mode;
  }

  void setPointSize(int size) {
    if (size > 0) {
      this.pointSize = size;
    }
  }
  void setMargin(int margin) {
    if (margin >= 0) {
      this.margin = margin;
      setMaximums();
      mapPoints();
    }
  }

  ArrayList<ArrayList<String>> getPointLabels() {
    return pointLabels;
  }

  void setPointLabels(ArrayList<ArrayList<String>> pointLabels) {
    this.pointLabels = pointLabels;
  }

  String getxLabel() {
    return xLabel;
  }

  void setxLabel(String xLabel) {
    if (xLabel != null) {
      this.xLabel = xLabel;
    }
  }

  String getyLabel() {
    return yLabel;
  }

  void setyLabel(String yLabel) {
    if (yLabel != null) {
      this.yLabel = yLabel;
    }
  }

  boolean isShowXAxis() {
    return showXAxis;
  }

  void setShowXAxis(boolean showXAxis) {
    this.showXAxis = showXAxis;
  }

  boolean isShowYAxis() {
    return showYAxis;
  }

  void setShowYAxis(boolean showYAxis) {
    this.showYAxis = showYAxis;
  }

  color getPointColour() {
    return pointColour;
  }

  void setPointColour(color pointColour) {
    this.pointColour = pointColour;
  }

  color getLineColour() {
    return lineColour;
  }

  void setLineColour(color lineColour) {
    this.lineColour = lineColour;
  }

  color getMainColour() {
    return mainColour;
  }

  void setMainColour(color mainColour) {
    this.mainColour = mainColour;
  }

  color getBackgroundColour() {
    return backgroundColour;
  }

  void setBackgroundColour(color backgroundColour) {
    this.backgroundColour = backgroundColour;
  }

  int getLineWidth() {
    return lineWidth;
  }

  void setLineWidth(int lineWidth) {
    if (lineWidth >0) {
      this.lineWidth = lineWidth;
    }
  }

  boolean isToDrawBorder() {
    return toDrawBorder;
  }

  void setToDrawBorder(boolean toDrawBorder) {
    this.toDrawBorder = toDrawBorder;
  }

  int getPointSize() {
    return pointSize;
  }

  int getMargin() {
    return margin;
  }
  
  void setDrawSpeed(float drawSpeed){
    this.drawSpeed = drawSpeed;
  }
  
  void setDrawTimeAndSpeedInSeconds(float time){          //in seconds
    this.drawTime = data.size();
    this.drawSpeed = drawTime/(frameRate*time);
  }
  
  void setDrawTimeInFrames(float timeInFrames){
    this.drawTime = timeInFrames;
  }
  
  void resetAnimation(){
    this.drawTimer = 0;
  }
}