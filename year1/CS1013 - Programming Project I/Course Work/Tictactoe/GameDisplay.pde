class GameDisplay{

  GameDisplay(){

 }
  void draw(){
    noStroke();
    fill(0);
      for(int i = 0; i < squareRows.length ; i++)
         for(int j = 0; j < squareColumns.length; j++){
      rect(squareColumns[j], squareRows[i], rectHeight, rectWitdh);
    }
    stroke(255);
    strokeWeight(3);
    line(MARGIN + rectWitdh, MARGIN, MARGIN + rectWitdh, MARGIN + 3 * rectHeight);
    line(MARGIN + 2 * rectWitdh, MARGIN, MARGIN + 2 * rectWitdh, MARGIN + 3 * rectHeight);
    
    line(MARGIN, MARGIN + rectHeight,  MARGIN + 3 * rectWitdh, MARGIN + rectHeight);
    line(MARGIN, MARGIN + 2 * rectHeight, MARGIN + 3 * rectWitdh, MARGIN + 2 * rectHeight);
  }
  
}