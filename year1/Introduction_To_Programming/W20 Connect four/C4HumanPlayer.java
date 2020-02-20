package ConnectFour;

import static ConnectFour.Connect4Game.newLineInput;

public class C4HumanPlayer extends ConnectPlayer {
    public C4HumanPlayer(int value) {
        super(value);
        setType("human");
    }

    @Override
    public int placeCoinAtCol(Connect4GridInterface gameGrid) {
        boolean coinplaced = false;
        int number = -1;
        while(!coinplaced){
            String colPos = null;
            while(number == -1){
                colPos = getLineNoExit("Enter the column index you wish to put a token in (1 to 7)");
                number = parseToInt(colPos) - 1;
                if(number > 6 || number < 0){
                    number = -1;
                    System.out.println("The column entered does not exist.");
                }
            }
            if(gameGrid.isValidColumn(number)){
                coinplaced = true;
            } else {
                System.out.println("Selected column is full, please try again with a different column.");
            }
        }
        return number;
    }
    public static int parseToInt(String line){
        int number = -1;
        if(line == null) return -1;
        try {
            number = Integer.valueOf(line);
        } catch (NumberFormatException e) {
            System.out.println("Error when parsing to an Integer, numeric value expected. Try again.");
        }
        return number;
    }
    public static String getLineNoExit(String message){
        boolean foundLine = false;
        String input = null;
        while(!foundLine){
            input = newLineInput(message + "." );
            if(input != null){
                foundLine = true;
            }
        }
        return input;
    }
}
