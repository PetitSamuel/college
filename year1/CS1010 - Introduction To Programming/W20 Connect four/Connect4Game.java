/* SELF ASSESSMENT

Connect4Game class (35 marks)35
My class creates references to the Connect 4 Grid and two Connect 4 Players. It asks the user whether he/she would like to play/quit inside a loop. If the user decides to play then: 1. Connect4Grid2DArray is created using the Connect4Grid interface, 2. the two players are initialised - must specify the type to be ConnectPlayer, and 3. the game starts. In the game, I ask the user where he/she would like to drop the piece. I perform checks by calling methods in the Connect4Grid interface. Finally a check is performed to determine a win.
Comment:sets up & runs the game. It first asks for 2 user types (AI or human) with the possibility of entering "exit" to stop playing. After a game, the user is given the choice to play again
(using a loop). During the first game the Connect4Grid2DArray is created using the interface.
As mentionned earlier the types of players are created accordingly to the user input.
Finally, the game plays asking repeatedly inputs from the users & checks the grid for winners & being full (using the interface)

Connect4Grid interface (10 marks)10
I define all 7 methods within this interface.
Comment: all 7 methods defined

Connect4Grid2DArray class (25 marks)25
My class implements the Connect4Grid interface. It creates a grid using a 2D array
Implementation of the method to check whether the column to drop the piece is valid.
It provides as implementation of the method to check whether the column to drop the piece is full.
It provides as implementation of the method to drop the piece.  It provides as implementation of the method to check whether there is a win.
Comment: Implements the interface. Creates a 2D array, implements and uses methodes from the interface to determine in a column is full/valid to put a coin in.
If the above condition is met then it also contains the implemented method to drop a token and also implements the method (divided into multiple) to check if the board currently has a winner or not


ConnectPlayer abstract class (10 marks)10
My class provides at lest one non-abstract method and at least one abstract method.
Comment:contains one abstract method which returns an integer index that corresponds to the column to drop the token in and 2 non abstract methods : getter and setter for the type.

C4HumanPlayer class (10 marks)10
My class extends the ConnectPlayer class and overrides the abstract method(s). It provides the Human player functionality.
Comment:extends the parent class, overrides the given method using command line inputs & checking if the chosen input is valid.
Enable a human player to play/decide where to play

C4RandomAIPlayer class (10 marks)10
My class extends the ConnectPlayer claas and overrides the abstract method(s). It provides AI player functionality.
Comment: extends the class and overrides the abstract method. Uses a brute force non very sophisticated approach to solving a power four grid.
uses a simple algorithm for the computer to find out where to play.

Total Marks out of 100:100

*/



package ConnectFour;

import java.util.Scanner;

public class Connect4Game {
    public static void main(String[] args) {
        String userType1 = getUserType();
        if(!userType1.equals("exit")){
            String userType2 = getUserType();
            if(!userType1.equals("exit")){
                playGame((userType1.toUpperCase().equals("IA")?0:1), (userType2.toUpperCase().equals("IA")?0:1));
            } else {
                System.out.println("End of game.");
            }
        } else {
            System.out.println("End of game.");
        }
    }
    public static void playGame(int playType1, int playType2){
        ConnectPlayer player1 = null;
        ConnectPlayer player2 = null;
        if(playType1 == 0){
            player1 = new C4RandomAIPlayer(1);
        } else {
            player1 = new C4HumanPlayer(1);
        }
        if(playType2 == 0){
            player2 = new C4RandomAIPlayer(2);
        } else {
            player2 = new C4HumanPlayer(2);
        }
        Connect4GridInterface grid = new Connect4Grid2DArray();
        boolean playing = true;
        while(playing){
            System.out.println("New game! (" + player1.getType() + ") Player1 VS (" + player2.getType() + ") Player2 !\n\n" + grid.toString());
            int count = 0;
            boolean won = false;
            while(!grid.isGridFull() && !won){
                System.out.println("Turn " + (count + 1) + ", " + ((count % 2 == 0)?"Player 1 : (" + player1.getType() + ")":"Player 2 : (" + player2.getType()+ ")"));
                if(count % 2 == 0){
                    int colToPlace = player1.placeCoinAtCol(grid);
                    grid.dropPiece(player1, colToPlace);
                } else {
                    int colToPlace = player2.placeCoinAtCol(grid);
                    grid.dropPiece(player2, colToPlace);
                }
                if(grid.didLastPieceConnect4()){
                    if(count % 2 == 0){
                        System.out.println("(" + player1.getType() + ") Player1 has won!\n");
                    } else {
                        System.out.println("(" + player2.getType() + ") Player2 has won!\n");
                    }
                    won = true;
                } else {
                    count++;
                    System.out.println(grid.toString() + "\n");
                }
            }
            if(!won){
                System.out.println("The grid is full! There is no winner.");
            } else {
                System.out.println(grid.toString());
            }
            System.out.println("End of the game. Play again? [Y/N]");
            if(newLineInput("").toUpperCase().equals("Y")){
                grid.emptyGrid();
            } else {
                playing = false;
                System.out.println("End of game.");
            }
        }
    }
    public static String getUserType() {
        String userType = "";
        while(!userType.toUpperCase().equals("IA") && !userType.toLowerCase().equals("human") && !userType.toLowerCase().equals("exit")){
            userType = getLine("exit", "Enter a player type ! (IA or human)");
        }
        return userType;
    }
    public static String getLine(String endCondition, String message){
        boolean foundLine = false;
        String input = null;
        while(!foundLine){
            input = newLineInput(message + ". Or enter " + endCondition);
            if(input.toLowerCase().equals(endCondition)){
                foundLine = true;
            } else if(input != null){
                foundLine = true;
            }
        }
        return input;
    }

    public static String newLineInput(String message) {
        Scanner scanner = new Scanner(System.in);
        String line = null;
        while (line == null) {
            System.out.println(message);
            line = scanner.nextLine();
        }
        return line;
    }
}
