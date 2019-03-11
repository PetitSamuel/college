import java.util.Scanner;

public class squareWholeNumber {

	public static void main(String[] args) {
		
		boolean finished = false;
		
		while(!finished)
		{
			Scanner input = new Scanner( System.in );
			System.out.println("Enter a number or type quit or exit");
			
			if(input.hasNextInt())
			{
				int numberEntered = input.nextInt();

				if(numberEntered <= 0)
				{
				System.out.println("Number is null or negative");
				}
				else
				{
					
					String outputText = "The numbers whose squares are less than or equal to " + numberEntered + " are ";
					for(int count = 0; count < numberEntered; count++)			
					{
						int countSquared = count * count;
						if(countSquared < numberEntered)
						{
							outputText += count + ",";
						}	
					}
					System.out.println(outputText);
				}
			}
			else if(input.hasNext("exit") || input.hasNext("quit") || input.hasNext("EXIT") || input.hasNext("QUIT"))
			{
				finished = true;
				System.out.println("The program has ended.");
			}
			else
			{
				System.out.println("Not a number. Please enter a valid number.");
			}			
		}
	}

}
