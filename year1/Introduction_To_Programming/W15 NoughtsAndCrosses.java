/* SELF ASSESSMENT 
   1. clearBoard:
Did I use the correct method definition?
Mark out of 5: 5
Comment: method that returns an initialised 2D array ( I decided to make mine return something instead of using a void )
Did I use loops to set each position to the BLANK character?
Mark out of 5:5
Comment: I defined the array using the '{ ... } method : it was easier to add coordinates and is more efficient (this is possible since there are not many positions
   2. printBoard
Did I use the correct method definition?
Mark out of 5: 5
Comment: void that takes a 2D array and prints it out in a formatted way using 2 for loops and if statements
Did I loop through the array and prints out the board in a way that it looked like a board?
Mark out of 5: 5
Comment: looks like a board and includes positions for the user
   3. canMakeMove
Did I have the correct function definition and returned the correct item?
Mark out of 5: 5
Comment: returns a boolean value, checking if the position entered is used already or not
Did I check if a specified location was BLANK?
Mark out of 5: 5
Comment: returns wether the position entered is blank (TRUE) or not (FALSE)
   4. makeMove
Did I have the correct function definition?
Mark out of 5:5
Comment: void that takes in a board and inserts the value at a the location entered (which has been checked to be empty earlier by the canMakeMove boolean)
Did I set the  currentPlayerPiece in the specified location?
Mark out of 5: 5
Comment:    sets the player character at the start of each position entry using an index that is incremented only when an extra token has been added  
   5. isBoardFull
Did I have the correct function definition and returned the correct item?
Mark out of 5: 5
Comment:        returns boolean value, checked after each entered token (has a 2D array parameter)
Did I loop through the board to check if there are any BLANK characters?
Mark out of 5:5
Comment: uses 2 for loops to check all of the board positions
   6. winner
Did I have the correct function definition and returned the winning character
Mark out of 5: 5
Comment:     takes in the board (a 2D array) and checks if a row/column or diagonal has all 3 of the same characters. Will return an empty char (' ') if there is no winner,
if however there is a winner, the winner's token will be returned
Did I identify all possible horizontal, vertical and diagonal winners  
Mark out of 15: 15
Comment: checks all rows, columns and diagonals for a winner
   7.main

Did I create a board of size 3 by 3 and use the clearBoard method to set all the positions to the BLANK character ('  ')?
Mark out of 3:3
Comments: creates a 4 by 4 board (positions help the user understand what to input), is set using the clearBoard method
Did I loop asking the user for a location until wither the board was full or there was a winner?
Mark out of 5:5
Comments: yes, using a while loop and a boolean variable
Did I call all of the methods above?
Mark out of 5:5
Comments: calls all methods at appropriate times to create a correct playing environment 
Did I handle incorrect locations provided by the user (either occupied or invalid locations)?
Mark out of 3:5
Comments: yes, using if statements as well as methods
Did I switch the current player piece from cross to nought and vice versa after every valid move?
Mark out of 3:3
Comments: using an index that is incremented after each count & a condition to set the current player's character
Did I display the winning player piece or a draw at the end of the game?
Mark out of 3:3
Comments: outputs a sentence which includes the winning player and also outputs the final board

   8. Overall
Is my code indented correctly?
Mark out of 3:3
Comments: is the Noughts and crosses game
Do my variable names and Constants (at least four of them) make sense?
Mark out of 3:3
Comments: variables make sense, constants include the 2 player characters as well as the boards dimmensions
Do my variable names, method names and class name follow the Java coding standard
Mark out of 2:2
Comments:coding standard respected
      Total Mark out of 100 (Add all the previous marks): 
*/

import java.util.Scanner;

public class NoughtsAndCrosses {
//main which gets input (location on the board) from the user until there is a winner or the board is full. 
//It calls all of the above methods and when the game is over presents the winner.
	public static char NOUGHT = 'O';
	public static char CROSS = 'X';
	public static int ROWS_COUNT = 4;
	public static int COLUMNS_COUNT = 4;
	public static void main(String[] args) {
		char [][] board = new char [ROWS_COUNT][COLUMNS_COUNT];
		board = clearBoard();		
		boolean finished = false;
		Scanner inputs = null;
		int index = 0;
		while(!finished)
		{
			char playerChar = (index % 2 == 0)? CROSS : NOUGHT;
			printBoard(board);
			inputs = new Scanner(System.in);
			System.out.println("\nPlayer " +  playerChar + " : enter the position you wish to fill (example : A1). Otherwise, enter 'exit' to end the game.");
			if(inputs.hasNext("exit"))
			{
				finished = true;
				System.out.println("Goodbye !");
			} else {
				String textInput = inputs.next();
				if(textInput.length() == 2 && (textInput.charAt(0) == 'A' || textInput.charAt(0) == 'B' || textInput.charAt(0) == 'C') && 
													(textInput.charAt(1) == '1' || textInput.charAt(1) == '2' || textInput.charAt(1) == '3'))
				{
					int row;
					switch(textInput.charAt(0)){
						case 'A' : 
							row = 0;
							break;
						case 'B' : 
							row = 1;
							break;
						default : 
							row = 2;
							break;
					}
					int column = Character.getNumericValue(textInput.charAt(1));
					if(canMakeMove(board, row, column))
					{
						index++;
						makeMove(board, playerChar,row, column);
					} else {
						System.out.println("Position is not available, enter a new position");
					}
					
				}else {
					System.out.println("Invalid position");
				}
			}
			if(isBoardFull(board))
			{
				finished = true;
				printBoard(board);
				System.out.println("\nThe board is full, there is no winner");
			} 
			else if(winner(board) != ' ')
			{
				finished = true;
				printBoard(board);
				System.out.println("\nPlayer "+ winner(board) + " wins !");
			}
		}
		inputs.close();
	}
	//sets all locations on the board to the BLANK (' ') character.
	public static char[][] clearBoard() {
		char [][] tmp = {{'A', ' ',' ', ' '}, {'B', ' ', ' ', ' '}, {'C', ' ', ' ', ' '}, {' ','1', '2', '3'}};
		return tmp;
	}
//void printBoard (char[][] board) which prints the board to the screen in the format shown.
	public static void printBoard(char [][] board) {
		for(int row = 0; row < board.length; row++)
		{
			if(row > 0) System.out.println("\n  ------------");
			for(int column = 0; column < board[row].length; column++)
			{
				if(column == 0) System.out.print(board[row][column]);
				else if(row == 3 || column == 1) System.out.print("   " + board[row][column]);
				else System.out.print(" | " + board[row][column]);	
			}
		}
	}
//boolean canMakeMove (char[][] board, int row, int column) which takes a board and a location and returns whether a move can be made there.
	public static boolean canMakeMove (char [][] board, int row, int column) {
		return board[row][column] == ' ';
	}
	
//void makeMove (char[][] board, char currentPlayerPiece , int row, int column) which adds a piece (NOUGHT or CROSS) to the board in the specified location.
	public static void makeMove(char [][] board, char currentPlayerPiece, int row, int column) {
		board[row][column] = currentPlayerPiece;
	}
//boolean isBoardFull(char[][] board) which indicates whether the board is full.
	public static boolean isBoardFull(char [][] board) {
		boolean output = true;
		for(int row = 0; row < board.length - 1 && output; row++)
			for(int column = 1; column < board[row].length && output; column++)
			{
				if(board [row][column] == ' ') output = false;
			}
		return output;
	}

//char winner ( char[][] board) which returns the piece which has won or BLANK if no-one has yet won.
	public static char winner(char [][] board) {
		char output = ' ';
		for(int rows = 0; rows < board.length && output == ' '; rows++)
		{
			if(board[rows][1] == board[rows][2] && board[rows][3] == board[rows][1])  output = board[rows][1];
		}
		for(int columns = 1; columns < board[0].length && output == ' '; columns++) {
			if(board[0][columns] == board[1][columns] && board[2][columns] == board[1][columns]) output = board[0][columns];
		}
		if(board[0][1] == board[1][2] && board[2][3] == board[0][1] && output == ' ') output = board[0][1];
		else if(board[2][1] == board[1][2] && board[0][3] == board[2][1] && output == ' ') output = board[2][1];
		return output;
	}
}
