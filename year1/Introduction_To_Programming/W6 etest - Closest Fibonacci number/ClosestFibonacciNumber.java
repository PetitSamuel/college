import java.util.Scanner;

public class ClosestFibonacciNumber {

	public static void main(String[] args) {
		
		boolean finished = false;
		Scanner input = null;
		
		while(!finished)
		{	
			input = new Scanner( System.in );
			System.out.print("What number would you like the closest Fibonacci "
													+ "number for : (or type 'exit' or 'quit' to exit): ");
			
			if (input.hasNextInt())
			{
				int numberEntered = input.nextInt();
				int secondLastFibonacciNumber = 0;
				int LastFibonacciNumber = 1;
				int fibonacci = 0;
				
				while(fibonacci <= numberEntered)
				{
					secondLastFibonacciNumber = LastFibonacciNumber;
					LastFibonacciNumber = fibonacci;
					fibonacci = secondLastFibonacciNumber + LastFibonacciNumber;
				}
				
				double distanceFibonacci = Math.abs(fibonacci - numberEntered);
				double distanceLastFibonacci = Math.abs(LastFibonacciNumber - numberEntered);
				
				if(distanceFibonacci == distanceLastFibonacci)
				{
					System.out.println("The closest Fibonacci numbers to "+ numberEntered
													+ " are " + fibonacci + " and " + LastFibonacciNumber);
				}
				else if(distanceFibonacci < distanceLastFibonacci)
				{
					System.out.println("The closest Fibonacci number to "+ numberEntered + " is " + fibonacci);
				}
				else
				{
					System.out.println("The closest Fibonacci number to "+ numberEntered 
																				+ " is " + LastFibonacciNumber);
				}
			}
			else if(input.hasNext("exit") || input.hasNext("quit"))
			{
				System.out.println("You have stopped the program");
				finished = true;
			}
			else
			{
				System.out.println("The input is not valid for this application.");
			}
		}
		input.close();
	}
}
