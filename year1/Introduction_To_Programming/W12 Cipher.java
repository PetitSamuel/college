/* SELF ASSESSMENT

 1. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?

        Mark out of 5:  5  all variables correctly formated and meaningful

 2. Did I indent the code appropriately?

        Mark out of 5: 5 it converts text from plain to cipher text and converts it back to normal

 3. Did I write the createCipher function correctly (parameters, return type and function body) and invoke it correctly?

       Mark out of 20:  20  It takes an ordered array of character and randomises it.
        					I decided to use a void (so no return) and manipulate the arrays directly

 4. Did I write the encrypt function correctly (parameters, return type and function body) and invoke it correctly?

       Mark out of 20:  20  It changes the original text to cipher text using the positions array and 
       						the randomised array of characters. I decided to use a void (so no return) and manipulate the arrays directly

 5. Did I write the decrypt function correctly (parameters, return type and function body) and invoke it correctly?

       Mark out of 20:  20, same principle as above , this time it takes the original array of characters and the array 
       containing the positions of each character from the input to convert it back to the original text.
       I again decided to use a void (so no return) and manipulate the arrays directly

 6. Did I write the main function body correctly (repeatedly obtaining a string and encrypting it and then decrypting the encrypted version)?

       Mark out of 25  25	main functions invokes all functions to repeatedly get a string input and then convert it, print out the converted version to the console and the decrypts it.

 7. How well did I complete this self-assessment?

        Mark out of 5:5 I think I explained enough how I designed my program

 Total Mark out of 100 (Add all the previous marks):100

*/ 

import java.util.Random;
import java.util.Scanner;

public class Cipher {
	public static final String ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789&й'()-и_за=+<>,?;.:/!";
	public static void main(String[] args) {
		Scanner input = null;
		boolean finished = false;
		while(!finished)
		{
			input = new Scanner(System.in);
			System.out.println("Enter some text, or type '/end' to end the program");
			if(input.hasNext("/end"))
			{
				finished = true;
				System.out.println("You have stopped the program");
				
			}
			else if(input.hasNextLine())
			{

				String textInput = input.nextLine();
				char [] arrayContainingCharacters = ALPHABET.toCharArray();
				char[] arrayInput = textInput.toCharArray();
				int [] charPositions = new int[arrayInput.length];
				charToPosition(arrayInput, arrayContainingCharacters, charPositions);
				createCipher(arrayContainingCharacters);
				encrypt(charPositions, arrayContainingCharacters, arrayInput);
				String tmpText = new String(arrayInput);
				System.out.println("Here is the encrypted text: " + tmpText);
				arrayContainingCharacters = ALPHABET.toCharArray();
				decrypt(charPositions, arrayContainingCharacters, arrayInput);
				tmpText = new String(arrayInput);
				System.out.print("Here is the original text, converted back from encrypted: "+ tmpText +"\n\n");
					
			}
			else
			{
				System.out.println("No input, please enter again.");
			}
		}
		input.close();
	}
	
	//uses Randomise order code taken from blackboard (to randomise the array containing the characters)
	public static void createCipher( char[] array )
	{
	  if (array!=null)
	  {
	    Random generator = new Random();
	    for (int index=0; index<array.length; index++ )
	    {
	      int otherIndex = generator.nextInt(array.length);
	      if(otherIndex != index)
	      {
		      char temp = array[index];
		      array[index] = array[otherIndex];
		      array[otherIndex] = temp;
	      }
	    }
	  }
	}
	
	//keeps the positions of each character from the input text (using the ordered character list) inside an array
	public static void charToPosition(char [] array, char [] alphabet, int [] positions)
	{
		for(int index = 0; index < array.length; index++)
		{
			int count = 0;
			while(array[index] != alphabet[count])
			{
				count++;
			}
			positions[index] = count;
		}
	}
	
	//gives each character from the input text the character that has been assigned 
	//to its position when randomising the array containing all characters
	public static void encrypt(int [] positions, char [] cipher, char [] text)
	{
		if (text!=null)
		 {
			for(int index = 0; index < text.length; index++)
			{
				text[index] = cipher[positions[index]];
			}
		 }
	}

	//uses the ordered character & the positions to convert the text from encrypted to the original text
	public static void decrypt(int [] positions, char [] alphabet, char [] text)
	{
		if (text!=null)
		 {
			for(int index = 0; index < text.length; index++)
			{
				text[index] = alphabet[positions[index]];
			}
		 }
	}
}
