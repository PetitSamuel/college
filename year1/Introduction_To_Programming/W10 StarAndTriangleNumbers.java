/* SELF ASSESSMENT
 1. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?
        Mark out of 5: 5        Comment: All variables formatted properly and have meaningful names
 2. Did I indent the code appropriately?
        Mark out of 5:  5       Comment: prints out all numbers contained in an integer that are star and triangle numbers
 3. Did I write the determineStarNumber or determineTriangleNumber function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 20: 20         Comment: I used the determineTriangleNumber function, returns a boolean value and gets a star number as parameter. 
       It is invoked to check if any star number is also a triangle number 
 4. Did I write the isStarNumber function correctly (parameters, return type and function body) and invoke it correctly?
       Mark out of 20: 20         Comment: I used "isTriangleNumber" instead of a star as I have found that star numbers grow faster (so it is more efficient).
       					The function is wrote correctly and outputs an integer that is equal or bigger than the star number that is entered into the function (the parameter).
 5. Did I calculate and/or check triangle numbers correctly?
       Mark out of 15:  15        Comment: triangle numbers are calculated and checked properly
 6. Did I loop through all possibilities in the program using system defined constants to determine when to stop?
       Mark out of 10:   10      Comment: the program does go through all the possibilities, stopping when needed and using defined constants
 7. Does my program compute and print all the correct triangular star numbers?
       Mark out of 20:  20      Comment: outputs 4 numbers : 1, 253, 49141, 9533161, 1849384153.
 8. How well did I complete this self-assessment?
        Mark out of 5: 5       Comment: I tried explaining as much as possible
 Total Mark out of 100 (Add all the previous marks): 100
*/ 

public class StarAndTriangleNumbers {

	public static void main(String[] args) {

		System.out.println("The numbers that are simultaneously star and triangle numbers are : ");

			int star = 1;
			int count = 1;
			do {
				star = 6 * count * (count - 1) + 1;
				count++;
				
				if(isTriangle(star))
				{
					System.out.print(star + ", ");
				}
			}while(star < Integer.MAX_VALUE && star > 0);		
	}
	
	public static boolean isTriangle(int number)
	{
//function that returns whether there is a triangle number equal to a number passed into the function or not
		return (determineTriangleNumber(number) == number);	
	}
	public static int determineTriangleNumber(int number)
	{
// calculates the triangle number until it is bigger or equal to a number (in this case a triangle number)
		int count = 0;
		int triangle = 0;
		do {
			triangle += ++count;
		}while(triangle < number);
		return triangle;
	}
}
