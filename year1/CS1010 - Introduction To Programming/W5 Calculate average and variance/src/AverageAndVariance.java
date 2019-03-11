/* SELF ASSESSMENT 
   1. Did I use easy-to-understand meaningful variable names? 
       Mark out of 10: 10
   2. Did I format the variable names properly (in lowerCamelCase)? 
       Mark out of 5: 5
   3. Did I indent the code appropriately? 
       Mark out of 10: 10
   4. Did I input the numbers one at a time from the command line?
       Mark out of 10:  10
   5. Did I check the input to ensure that invalid input was handled appropriately?
       Mark out of 10:  10
   6. Did I use an appropriate while or do-while loop to allow the user to enter numbers until they entered exit/quit?
       Mark out of 20:  20
   7. Did I implement the loop body correctly so that the average and variance were updated and output appropriately?
       Mark out of 30:  30
   8. How well did I complete this self-assessment? 
       Mark out of 5: 5
   Total Mark out of 100 (Add all the previous marks): 100
*/

//Add : number layout, close scanner??
import java.util.Scanner;

public class AverageAndVariance {

	public static void main(String[] args) {
		
 		boolean finished = false;
		int numberCount = 0;
		double average = 0;
		double variance = 0;
 		
		while(!finished)
		{
			Scanner input = new Scanner( System.in );
			System.out.print("Enter a whole number (or type 'exit' or 'quit'): ");
			
			if (input.hasNextInt())
			{
				int lastNumberEntered = input.nextInt();
				double previousAverage = average;
				average = average +(lastNumberEntered  - average) / ++numberCount; 
				
				variance = (((variance * (numberCount - 1)) + (lastNumberEntered - previousAverage)*(lastNumberEntered - average))/numberCount);
				System.out.println("the average is " + average + " the variance is " + variance);
			}
			else if(input.hasNext("exit") || input.hasNext("quit") || input.hasNext("'exit'") || input.hasNext("'quit'"))
			{	
				finished = true;
				System.out.println("You have stopped the program");
			}
			else
			{
				System.out.println("Not a valid whole number.  Try again.");
			}
		}
	}

}
