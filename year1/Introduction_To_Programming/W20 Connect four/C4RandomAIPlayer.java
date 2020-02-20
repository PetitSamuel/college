package ConnectFour;

public class C4RandomAIPlayer extends ConnectPlayer {
    public C4RandomAIPlayer(int value) {
        super(value);
        setType("A.I.");
    }

    @Override
    public int placeCoinAtCol(Connect4GridInterface gameGrid) {
        boolean foundSpot = false;
        int col = 0;
        while (!foundSpot){
            if(gameGrid.isValidColumn(col)){
                foundSpot = true;
            } else {
              col++;
            }
        }
        return col;
    }
}
