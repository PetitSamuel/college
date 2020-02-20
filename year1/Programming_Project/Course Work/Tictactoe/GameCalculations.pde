class GameCalculations{
 char [][] template = {{' ',' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '}};
 char [][] board = new char [3][3];
 int row; int column;
       GameCalculations(){
          board = template;
       }
    void getRowAndColumn (int x, int y){
      row = 5;
      column = 5;
      for(int i = 0; i < squareRows.length && !false; i++){
        if( x > MARGIN && x < squareRows[2] + rectWitdh && y > squareColumns[i] && y < squareColumns[i] + rectHeight){
          row = i;
        }
      }
        for(int j = 0; j < squareColumns.length && !false; j++){
          if( y > MARGIN && y < squareColumns[2] + rectWitdh && x > squareRows[j] && x < squareRows[j] + rectHeight){
            column = j;
        }
      }
    }
    boolean canMakeMove (int i, int j) {
      if(row != 5 && column != 5) return board[i][j] == ' ';
      else return false;
    }
    void makeMove(int r, int c, char character){
      board[r][c] = character;      
    }
    void draw(){
     textFont(font, 35);
     fill(255);
     font = loadFont("Arial-Black-30.vlw");  
     for(int i = 0; i < board.length; i ++)
       for(int j = 0; j < board[i].length; j++){
          if(board[i][j] != ' '){
           text(board[i][j], squareColumns[j] + 12, squareRows[i] + rectHeight - 10);
          }
       }
    }
    
    char winner() {
      char output = ' ';
      for(int rows = 0; rows < board.length && output == ' '; rows++)
      {
        if(board[rows][0] == board[rows][1] && board[rows][2] == board[rows][0])  output = board[rows][0];
      }
      for(int columns = 0; columns < board.length && output == ' '; columns++) {
        if(board[0][columns] == board[1][columns] && board[2][columns] == board[0][columns]) output = board[0][columns];
      }

      if(board[0][0] == board[1][1] && board[2][2] == board[0][0] && board[0][0] != ' ' && output == ' ') output = board[1][1];
      else if(board[2][0] == board[1][1] && board[0][2] == board[1][1] && board[1][1] != ' ' && output == ' ') output = board[1][1];
       return output;
    }

    
   boolean isBoardFull() {
    boolean output = true;
    for(int row = 0; row < board.length && output; row++)
      for(int column = 0; column < board[row].length && output; column++)
      {
        if(board [row][column] == ' ') output = false;
      }
    return output;
  } 
  boolean clickToReset(int x, int y){
    return (x > 0 && x < SCREENX && y > 225 && y < SCREENY);
  }
}