package ConnectFour;

public class Connect4Grid2DArray implements Connect4GridInterface {
    int [][] grid;

    public Connect4Grid2DArray() {
        grid = new int[][]{
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}};
    }

    @Override
    public void emptyGrid() {
        grid = new int[][]{
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}};
    }
    @Override
    public String toString(){
        StringBuilder builder = new StringBuilder();
        for(int row = 0; row < grid.length;row++){
            for(int col = 0; col < grid[row].length;col++){
                builder.append(grid[row][col] + " ");
            }
            builder.append("\r\n");
        }
        return builder.toString();
    }

    @Override
    public boolean isValidColumn(int column) {
        return !isColumnFull(column);
    }

    @Override
    public boolean isColumnFull(int column){
        for(int i = 0; i < grid.length; i++){
            if(grid[i][column] == 0) return false;
        }
        return true;
    }
    @Override
    public void dropPiece(ConnectPlayer player, int column){
        if(!isColumnFull(column)){
            boolean pieceDropped = false;
            int index = 0;
            while (!pieceDropped){
                if(grid[5-index][column] == 0){
                    this.grid[5-index][column] = player.value;
                    pieceDropped = true;
                    System.out.println("Token dropped at [" + (index+1) + "," + (column+1) + "]");
                }else{
                   index++;
                }
            }
        }
    }
    @Override
    public boolean didLastPieceConnect4(){
        return (checkColumns() || checkRows() || checkDiagonals());
    }
    @Override
    public boolean isGridFull(){
        for(int i = 0;i<grid[0].length;i++){
            if(!isColumnFull(i)){
                return false;
            }
        }
        return true;
    }

    public boolean checkColumns(){
        for(int i = 0; i < grid[0].length;i++){
            if(checkColumn(i)){
                System.out.println("Col returned true");
                return true;
            }
        }
        return false;
    }
    public boolean checkColumn(int column){
        for(int j = 0; j<this.grid.length-3;j++){
            if(grid[j][column] == grid[j+1][column] &&  grid[j+1][column] == grid[j+2][column] && grid[j+2][column] == grid[j+3][column] && grid[j][column] !=0){
                return true;
            }
        }
        return false;
    }
    public boolean checkRows(){
        for(int i = 0; i < grid.length;i++){
            if(checkRow(i)){
                return true;
            }
        }
        return false;
    }
    public boolean checkRow(int row){
        for(int j = 0; j<this.grid[row].length-3;j++){
            if(grid[row][j] == grid[row][j+1] &&  grid[row][j+1] == grid[row][j+2] && grid[row][j+2] == grid[row][j+3]&& grid[row][j] !=0){
                return true;
            }
        }
        return false;
    }
    public boolean checkDiagonals(){
        return (checkDiagToTheRight()||checkDiagToTheLeft());
    }
    public boolean checkDiagToTheRight(){
        for(int row = 0; row < grid.length - 3; row++){
            for(int col = 0; col < grid[0].length - 3; col++){
                if(grid[row][col] == grid[row+1][col+1] &&  grid[row+2][col+2] == grid[row+1][col+1] && grid[row+2][col+2] == grid[row+3][col+3]&& grid[row][col] !=0){
                    return true;
                }
            }
        }
        return false;
    }
    public boolean checkDiagToTheLeft(){
        for(int row = 0; row < grid.length - 3; row++){
            for(int col = grid[0].length - 1; col > 2; col--){
                if(grid[row][col] == grid[row+1][col-1] &&  grid[row+2][col-2] == grid[row+1][col-1] && grid[row+2][col-2] == grid[row+3][col-3]&& grid[row][col] !=0){
                    return true;
                }
            }
        }
        return false;
    }
}
