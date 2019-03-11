import javax.swing.JOptionPane;
import java.util.Scanner;

public class MaximumAndMinimum {

	public static void main(String[] args) {
	
		int maximum = 0;
		int minimum = 0;
		boolean finished = false;
		
		while(!finished)
		{
			String input = JOptionPane.showInputDialog(null, "Enter a list of numbers seperated by a ',' ");
			Scanner inputScanner = new Scanner(input);
			inputScanner.useDelimiter(",");
			
				if(inputScanner.hasNextInt())
				{
					finished = true;
					maximum = inputScanner.nextInt();
					minimum = maximum;
					
					while(inputScanner.hasNextInt())
					{
						int tmp = inputScanner.nextInt();
						
						if(tmp > maximum)
						{
							maximum = tmp;
						}
						else if(tmp < minimum)
						{
							minimum = tmp;
						}
					}
				}
				else
				{
					System.out.println("Please enter a valid list of numbers seperated by ',' ");
				}
		}
	System.out.println("the maximum is " + maximum +" and the minimum is " + minimum);
		
	}
}
