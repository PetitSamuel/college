import java.util.Scanner;

public class SolvingDegreeTwoEquations {

	public static void main(String[] args) {
		
		boolean finished = false;
		Scanner input = null;
		while(!finished)
		{
			input = new Scanner( System.in );
			System.out.println("Enter the coefficients of your second order polynomial, seperated by spaces. Or enter 'exit'");

			
			if(input.hasNextInt())
			{
				int coefA = input.nextInt(); 
				if(input.hasNextInt())
				{
					int coefB = input.nextInt(); 
					if(input.hasNextInt())
					{
						int coefC = input.nextInt(); 
						double delta = (coefB * coefB)- (4 * coefA * coefC);
						
						if(delta < 0)
						{
							System.out.println("There are no values of x in R which solve this equation");
						}
						else if(delta == 0)
						{
							double valueX = (- coefB) / (2 * coefA);
							System.out.println("Since Delta has a value of 0, there is only one value for x which solves this equation : " + valueX);	
						}
						else 
						{
							delta = Math.sqrt(delta);
							double valueXOne = (-coefB + delta) / (2 * coefA);
							double valueXTwo = (-coefB - delta) / (2 * coefA);
							System.out.println("The roots of this equation are x = " + valueXOne + " and x = " + valueXTwo );
						}	
					}
					else
					{
						System.out.println("Coefficient C not valid, please enter 3 valid numbers");
					}
				}
				else
				{
					System.out.println("Coefficient B not valid, please enter 3 valid numbers");
				}
				
			}
			else if(input.hasNext("exit") || input.hasNext("quit") || input.hasNext("EXIT") || input.hasNext("QUIT"))
			{
				finished = true;
				System.out.println("The program has ended");
			}
			else
			{
				System.out.println("Number not valid, please enter 3 valid numbers.");
			}			
		}
		input.close();
	}
}
