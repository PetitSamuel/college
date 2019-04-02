/* @author David Hooban
*  This class is the bar graph generation and display class. Creating an instance of a bar graph requires an arrayList of data to be passed in the constructor.
*/


class BarGraph
{
  int maxValueX;        // what is the largest value on the x-axis?
  int maxValueY;        // what is the largest value on the y-axis?
  float segmentAmount =0;    //how many points the axis should be divided into. E.g for stars there are 5 ratings possible, so 5 segments.
  float yAxisLength;    // physical length of the y-axis
  float xAxisLength;
  int segmentHeight = 20; // length of the segment lines
  int x;   // start position co-ordinate (should be done in constructor)
  int y;
  int boxLength = 50;    
  int boxWidth = 10;
  int offset;
  ReviewsStats rs;
  ArrayList<Float> starCounter = new ArrayList<Float>();
  ArrayList<Float> starCounterDup;
  boolean callScale = true;
  color barColor;
  String xAxisLabel;
  String yAxisLabel;
  int axisLineWidth = 1;
  PFont font;
  color barOne, barTwo, barThree, barFour, barFive;
  int max; // max value for one of the bars
  int yAxisNumOffset = 50;
  float currentValue=0;

   ArrayList<Float> segmentPosX;
   ArrayList<Float> segmentPosY;
   ArrayList<Float> newList;

  BarGraph(int maxValueX, int maxValueY, float segmentAmount, float yAxisLength, float xAxisLength, int boxLength, int boxWidth, int offset, ReviewsStats rs,color barColor, String xAxisLabel, 
                  String yAxisLabel, int x, int y, PFont font)                                                                                   
  {
    this.maxValueX = maxValueX;
    this.maxValueY = maxValueY;
    this.segmentAmount = segmentAmount;
    this.yAxisLength = yAxisLength;
    this.xAxisLength = xAxisLength;
    this.boxLength = boxLength;
    this.boxWidth = boxWidth;
    this.offset = offset;
    this.rs = rs;
    this.barColor = barColor;
    this.xAxisLabel = xAxisLabel;
    this.yAxisLabel = yAxisLabel;
    this.x = x;
    this.y = y;
    starCounter = scaleBoxes(rs.getStarsStats());
    this.font = font;
    starCounterDup = new ArrayList<Float>(starCounter);

  }
  
  void drawSegments()
  {
    segmentPosX = new ArrayList<Float>();
    segmentPosY = new ArrayList<Float>();
    //x-axis first
    double segLength = xAxisLength / segmentAmount;
    double addAmount = segLength;
    
    while (segLength <= xAxisLength)
    {
      segmentPosX.add((float)segLength);
      segLength = segLength + addAmount;
    }

    //then y-axis
    segLength = yAxisLength / segmentAmount;
    addAmount = segLength;
    while (segLength <= xAxisLength)
    {
      segmentPosY.add((float)segLength);
      segLength = segLength + addAmount;
    }
    
    //y-axis segments
    for(int i =0; i < segmentPosY.size(); i++)
    {
      
      if(i<5)
        rect(x-segmentHeight, y+boxLength - segmentPosY.get(i), segmentHeight, 1);
    }
    
  }
  
  ArrayList<Float> scaleBoxes(ArrayList<Integer> list)
  {
    max = 0;
    newList = new ArrayList<Float>();
    ArrayList<Float> fractionalList = new ArrayList<Float>();
    
    //finding the biggest number in the given list.
    for(int i =0; i < list.size(); i++)
    {
     // println(list.get(i));
      if(list.get(i) > max)
      {
        max = list.get(i);
      }    
    }
    
    //finding the divisor number for each element that is not the max.
    for(int j =0; j < list.size(); j++)
    {
      if(list.get(j) != max)
      {
        float tmp = list.get(j);
        float div = tmp/max;
        fractionalList.add(div);
      }
       else
      {
        fractionalList.add(j,1.0);
      }
      
 
    }
    
    //multiplying the divisor decimal by the max height (the y-axis length) to get the scaling ratio for each box.
    for(int i=0; i < fractionalList.size();i++)
    {
      float newValue = (yAxisLength * fractionalList.get(i) - boxLength);
      newList.add(newValue);
    }  
    return newList;
  }
  
  void drawBoxes()
  {
    determineBarColors();
         fill(barOne);
         rectMode(CORNERS);
         rect(x + segmentPosX.get(0) - offset, y+boxLength, x + segmentPosX.get(0) - offset + boxWidth, y-starCounterDup.get(0));
         fill(barTwo);
         rect(x + segmentPosX.get(1) - offset, y+boxLength, x + segmentPosX.get(1) - offset + boxWidth, y-starCounterDup.get(1));
         fill(barThree);
         rect(x + segmentPosX.get(2) - offset, y+boxLength, x + segmentPosX.get(2) - offset + boxWidth, y-starCounterDup.get(2));
         fill(barFour);
         rect(x + segmentPosX.get(3) - offset, y+boxLength, x + segmentPosX.get(3) - offset + boxWidth, y-starCounterDup.get(3));
         fill(barFive);
         rect(x + segmentPosX.get(4) - offset, y+boxLength, x + segmentPosX.get(4) - offset + boxWidth, y-starCounterDup.get(4));
         rectMode(CORNER);
  }
  
  void animateGraphBarHeights()
  {
       float max1 = starCounter.get(0);
       if(currentValue < max1)
       starCounterDup.set(0, currentValue);    
       
       float max2 = starCounter.get(1);
        if(currentValue < max2)
       starCounterDup.set(1, currentValue);    
       
       float max3 = starCounter.get(2);
        if(currentValue < max3)
       starCounterDup.set(2, currentValue);    
       
       float max4 = starCounter.get(3);
        if(currentValue < max4)
       starCounterDup.set(3, currentValue);    
       
       float max5 = starCounter.get(4);
        if(currentValue < max5)
       starCounterDup.set(4, currentValue);    
       
       currentValue = currentValue + 7.5;
       
        drawBoxes();    
     
  }
  
  void determineBarColors()
  {
      barOne = color(204, 0, 0);
      barTwo = color(255, 102, 102);
      barThree = color(255, 255, 51);
      barFour = color(159, 255, 128);
      barFive = color(0, 153, 51);
  }
  
  void drawNumbersOnYAxis()
  {
    fill(0);
    float value = max/segmentAmount;
    //number 5
    text(max,x - yAxisNumOffset, y- yAxisLength+boxLength);  
    //number 4
    text(nf((value*4), 0, 1),x- yAxisNumOffset,(y-yAxisLength)+segmentPosY.get(1)-boxLength);
    //number 3
    text(nf((value*3), 0, 1),x- yAxisNumOffset,(y-yAxisLength)+segmentPosY.get(2)-boxLength);
    //number 2
    text(nf((value*2), 0, 1),x- yAxisNumOffset,(y-yAxisLength)+segmentPosY.get(3)-boxLength);
    //number 1
    text(nf((value), 0, 1),x- yAxisNumOffset,(y-yAxisLength)+ segmentPosY.get(4)-boxLength);
    //0? at x,y

    
  }
  
  void drawAxis()
  {
    fill(0);
    
    rect(x, y+boxLength,xAxisLength,axisLineWidth);    //x-axis
    rect(x, y+boxLength - yAxisLength, axisLineWidth,yAxisLength);    //y-axis
  }
  
  void drawLabels()
  {
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(this.font, 30);
    text("Reviews statistics", x +(xAxisLength/2), y - yAxisLength);
    textFont(this.font, 20);    
    text("Star ratings",x+(xAxisLength/2), y+ boxLength + offset);
  }

  void draw()
  { 
    drawAxis();
    drawSegments();
    drawLabels();
    drawNumbersOnYAxis();

    animateGraphBarHeights();

  }
}