
public class PrimeNumbers {

	public static void main(String[] args) {

		System.out.println("Prizes should be given to the competitors who come ");
		int input = 30;
		
		for(int count = 1; count < input + 1; count++)
		{
			switch (count)
			{
			case 1:
			case 2:
			case 3:
				System.out.print(count);
				System.out.print((count == 1)?"st, ": (count ==2)?"nd, ":"rd, ");
				break;
			default :
				boolean prime = true;
				for(int divisible = 2; divisible < count; divisible ++)
				{
					if(count % divisible == 0)
					{
						prime = false;
					}
				}
				if(prime)
				{
					int lastDigit = count%100;
					System.out.print(count);
					if(lastDigit == 13)
					{
						System.out.print("th, ");
					}
					else if(lastDigit % 10 == 3)
					{
						System.out.print("rd, ");
					}
					else
					{
						System.out.print("th, ");
					}
					
				}
				break;
			}
		}
	}

}
