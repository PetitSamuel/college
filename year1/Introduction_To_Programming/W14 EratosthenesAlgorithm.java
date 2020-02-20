import java.util.Scanner;

public class EratosthenesAlgorithm {
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		System.out.println("Enter an integer bigger than 2");
		if(input.hasNextInt())
		{
			boolean primes [] = createSequence(input.nextInt());
			System.out.println(nonCrossedOutSubseqToString(primes));
			primes = sieve(primes);
			System.out.println(nonCrossedOutSubseqToString(primes));
		}
		else
		{
			System.out.println("The input entered is not an Integer");
		}
		input.close();
	}
	public static boolean [] createSequence(int number)
	{
		//+1 allows to have the boolean at index i to represent if i is a boolean or not (instead of i - 1)
		boolean array [] = new boolean[number + 1];
 		if(number >= 2)
		{
			for(int index = 2; index < array.length; index++)
			{
				array[index] = true;
			}
			return array;
		}
		else
		{
			System.out.println("Number entered is not bigger or equal to 2");
			return null;
		}
	}

	public static String nonCrossedOutSubseqToString(boolean [] array)
	{
		if(array != null)
		{
			String output = "";
			for(int count = 2; count < array.length; count++)
			{
				if(count == 2)
				{
					output += "2";
				}
				else if(array[count])
				{
					output = output + (", " + count);
				}	
			}
				return output;		
		}
		else
		{
			return "Error : the array is empty";
		}
			
	}

	public static String sequenceToString(boolean [] array)
	{
		String output = "";
		for(int count = 2; count < array.length; count++)
		{
			if(count == 2)
			{
				output += "2";
			}
			else if(array[count])
			{
				output = output + (", " + count);
			}
			else
			{
				output = output + (", [" + count + "]");
			}
		}
		return output;
	}
	
	public static boolean [] sieve(boolean [] array)
	{
		if(array != null)
		{
			boolean tmpArray [] = new boolean[array.length];
			System.arraycopy(array, 0, tmpArray, 0, array.length);
			for(int index = 2; index * index < array.length; index++)
			{
				if(tmpArray[index])
				{
					tmpArray = crossOutHigherMultiples(index, tmpArray);
					System.out.println(sequenceToString(tmpArray));
				}
			}
			return tmpArray;	
		}
		else
		{
			return null;
		}
	}
	
	public static boolean [] crossOutHigherMultiples(int number, boolean [] array)
	{
		boolean tmpArray [] = new boolean[array.length];
		System.arraycopy(array, 0, tmpArray, 0, array.length);
		for(int index = number * 2; index < array.length; index+= number)
		{
				tmpArray[index] = false;
		}
		return tmpArray;
	}

}