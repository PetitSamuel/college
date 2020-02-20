/* SELF ASSESSMENT
 1. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?
        Mark out of 5:  5, all names are properly formated and are meaningful
 2. Did I indent the code appropriately?
        Mark out of 5: 5 Yes, it takes in high scores into an array (of a user-set size) & prints it out afterwards.
 3. Did I write the initialiseHighScores function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 15:  Yes, it does initialise the array correctly, the parameters/returns are correct
 4. Did I write the printHighScores function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 15:  Yes, it prints all the numbers (that are not 0) in the array and has a correct format (unless the array is full of zeros)
 5. Did I write the higherThan function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 15: 15  Yes, it will return a boolean value which will determine if the new value can be placed or not.
       but it is never executed by my program in this version).
 6. Did I write the insertScore function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 20:20  Yes, insert the scores at the appropriate place, keeping the original array size
 7. Did I write the main function body correctly (first asking for the number of scores to be maintained and then repeatedly asking for scores)?
       Mark out of 20:20  Yes, it will ask for how many high scores to enter, and then will keep taking in numbers (unless the user types stop). When the array is full, 
       the user will decide if he wants to add more or not
 8. How well did I complete this self-assessment?
        Mark out of 5:5 I think I explained enough of the program
 Total Mark out of 100 (Add all the previous marks):100
*/ 

import java.util.Scanner;

import javax.swing.JOptionPane;

public class HighScores {

	public static void main(String[] args) {
		System.out.println("Enter how many scores you would like to enter.");
		Scanner scanner = new Scanner (System.in);
		if(scanner.hasNextInt())
		{
			int quantity = scanner.nextInt();
			if(quantity > 0)
			{
				int [] highScores = new int[quantity];
				highScores = initialiseHighScores(highScores);
				int count = 0;
				Scanner inputNumbers = null;
				boolean finished = false;
				while(!finished)
				{
					count++;
					inputNumbers = new Scanner (System.in);
					System.out.println("Enter a new high score (or type stop)");
					if(inputNumbers.hasNextInt())
					{
						int newNumber = inputNumbers.nextInt();
						if(higherThan(highScores, newNumber))
						{
							highScores = insertScore(highScores, newNumber);
						}
					}
					else if(inputNumbers.hasNext("stop"))
					{
						finished = true;
						System.out.println("You have stopped filling the highscores.");
					}
					else
					{
						System.out.println("Input is invalid");
					}
					
					if(count >= quantity)
					{
						Scanner extraNumber = new Scanner (System.in);
						System.out.println("You have reached the amount of numbers you wanted to enter. Do you wish to add another number? Y/N");
						if(extraNumber.hasNext("Y") || extraNumber.hasNext("yes"))
						{
						}
						else if(extraNumber.hasNext("N") || extraNumber.hasNext("no"))
						{
							finished = true;
							System.out.println("You have finished entering numbers");
						}
						else
						{
							finished = true;
							System.out.println("Invalid answer, therefore the program has finished taking in values.");
						}
					}
				 }
			inputNumbers.close();
			printHighScores(highScores);
			}
		}
		else
		{
			System.out.println("The input is not correct. (negative value or not a number)");
		}
		scanner.close();
	}
	
	
//Sets all values from the array to 0	
	public static int [] initialiseHighScores(int [] scores)
	{
			int [] array = new int[scores.length];
			for(int index = 0; index < scores.length; index++)
			{
				array[index] = 0;
			}
			return array;	
	}
	//prints out all the values in the array (stops if the next numbers are zeros)
	public static void printHighScores(int [] array)
	{
		if(array != null)
		{
			System.out.println("The high scores are : ");
			for(int index = 0; index < array.length; index++)
			{
				if(array[index] == 0)
				{
					index = array.length;
				}
				else
				{
					if(index == 0)
					{
						System.out.print(array[index]);
					}
					else if(index == array.length)
					{
						System.out.print(", " + array[index]);
					}
					else
					{
						System.out.print(", " + array[index]);
					}	
				}
			}
		}
		else
		{
			System.out.println("There are no values to show.");
		}
	}
	// determines whether a value can be added into the array or not
	public static boolean higherThan(int [] array, int score)
	{
		if(array != null)
		{
			for(int index = 0; index < array.length; index++)
			{
				if(score > array[index])
				{
					return true;
				}
			}
			return false;
		}
		else
		{
			return true;
		}
	}
	
	//adds a value into the array at the correct position (keeping the array's size if it is full
	public static int [] insertScore(int [] array, int number)
	{
		if(array != null && number > 0)
		{
			int [] tmp = new int [array.length + 1];
			int numberIndex = 0;
			for(int index = 0; index < array.length + 1; index ++)
			{
				if(number > array[index])
				{
					numberIndex = index;
					index = array.length + 1;
				}
			}
			int filler = 0;
			for(int count = 0; count + filler < tmp.length; count++)
			{
				if(count == numberIndex)
				{
					tmp[count] = number;
					filler = 1;
					tmp[count + filler] = array[count];
				}
				else
				{
					tmp[count + filler] = array[count];
				}
			}
			int [] tmp2 = new int [array.length];
			System.arraycopy(tmp, 0, tmp2, 0, tmp2.length);
			return tmp2;
		}
		else
		{
			return null;
		}
		
	}
}

