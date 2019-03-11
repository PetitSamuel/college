/* SELF ASSESSMENT 
   1. Did I use appropriate CONSTANTS instead of numbers within the code? 
       Mark out of 5: 5
       Comment: The only numbers I find deserve constants are the values for the jack, queen, king and ace cards 
   2. Did I use easy-to-understand, meaningful CONSTANT names formatted correctly in UPPERCASE? 
       Mark out of 5: 5
       Comment:
   3. Did I use easy-to-understand meaningful variable names? 
       Mark out of 10: 10
       Comment:  
   4. Did I format the variable names properly (in lowerCamelCase)? 
       Mark out of 5: 5
       Comment:  
   5. Did I indent the code appropriately? 
       Mark out of 10: 10 
       Comment:  
   6. Did I use an appropriate loop to allow the user to enter their guesses until they win or lose? 
       Mark out of 20: 20
       Comment:  while loop
   7. Did I check the input to ensure that invalid input was handled appropriately? 
       Mark out of 10: 9
       Comment: Can be improved : when invalid input it would be convenient to keep the same card instead of another one. Not essential to the game working though
   8. Did I generate the cards properly using random number generation (assuming all cards are equally likely each time)? 
       Mark out of 10: 10
       Comment:  
   9. Did I output the cards correctly as 2, 3, 4, ... 9, 10, Jack, Queen, King? 
       Mark out of 10: 10
       Comment:  
   10. Did I report whether the user won or lost the game before the program finished? 
       Mark out of 10: 10
       Comment:  
   11. How well did I complete this self-assessment? 
       Mark out of 5: 5
       Comment:  
   Total Mark out of 100 (Add all the previous marks): 99
*/

import java.util.Random;
import java.util.Scanner;

public class HiLowCardGame {
	
	public static final int ACE = 14;
	public static final int KING = 13;
	public static final int QUEEN = 12;
	public static final int JACK = 11;

	public static void main(String[] args) {

		System.out.println("To win you must guess if the next card is higher, lower or equal correctly 4 times in a row. "
																							+ "To stop the program type 'exit' or 'quit'");
		Scanner input = null;
		boolean finished = false;			
		int correctAnswersCount = 0;
		Random  generator = new Random();
		int nextCard = generator.nextInt(13) + 2;
		
		while(!finished)
		{

//displays what is the current card			
			if(nextCard > 10)
			{
				if(nextCard == JACK)
				{
					System.out.println("The card is a Jack");
				}
				else if(nextCard == QUEEN)
				{
					System.out.println("The card is a Queen");
				}
				else if(nextCard == KING)
				{
					System.out.println("The card is a King");
				}
				else if(nextCard == ACE)
				{
					System.out.println("The card is an Ace");
				}
			}
			else
			{
				System.out.println("The card is a " + nextCard);
			}
//input is taken and next card is generated			
			input = new Scanner(System.in);
			System.out.println("Do you think the next card will be higher, lower or equal?");
			int card = nextCard;
			nextCard = generator.nextInt(13) + 2;	
		
//the answers are checked, if they are right, a point is awarded, if not the program is stopped			
			if(input.hasNext("higher") || input.hasNext("Higher") || input.hasNext("HIGHER"))
			{
				if(nextCard - card > 0)
				{
					correctAnswersCount  += 1;
					System.out.println("Your answer is correct, you have now succeded " + correctAnswersCount + " times");
				}
				else
				{
					finished = true;
					System.out.println("The answer is wrong, better luck next time! You acheived a total of "
							+ correctAnswersCount + " correct answers");				}
			}
			else if(input.hasNext("lower") || input.hasNext("Lower") || input.hasNext("LOWER"))
			{
				if(card - nextCard > 0)
				{
					correctAnswersCount += 1;
					System.out.println("Your answer is correct, you have now succeded " + correctAnswersCount + " times");

				}
				else
				{
					finished = true;
					System.out.println("The answer is wrong, better luck next time! You acheived a total of "
																							+ correctAnswersCount + " correct answers");						
				}	
			}
			else if(input.hasNext("equal") || input.hasNext("Equal") || input.hasNext("EQUAL"))
			{
				if(card == nextCard)
				{
					correctAnswersCount += 1;
					System.out.println("Your answer is correct, you have now succeded " + correctAnswersCount + " times");

				}
				else
				{
					finished = true;
					System.out.println("The answer is wrong, better luck next time! You acheived a total of " 
																								+ correctAnswersCount + " correct answers");						
				}
			}
//Exits the program if the user entered 'exit' or 'quit'
			else if(input.hasNext("exit") || input.hasNext("Exit") || input.hasNext("EXIT") || input.hasNext("quit") 
																							|| input.hasNext("Quit") || input.hasNext("QUIT"))
			{
				System.out.print("You have stopped the program.");
				finished = true;
			}
//Handles if input doesn't fit any of the above options
			else
			{
				System.out.println("You didn't insert a correct answer for this application, please answer with 'lower','higher' or 'equal'");
			}
//stops the program if user won the game (won 4 times in a row)
			if(correctAnswersCount == 4)
			{
				finished = true;
				System.out.println("Congratulations.  You got them all correct.");
			}
		}
		input.close();
	}
}
