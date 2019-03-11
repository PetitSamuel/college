/* SELF ASSESSMENT 
   1. Did I use appropriate CONSTANTS instead of numbers within the code?  
       Mark out of 5: 5
   2. Did I use easy-to-understand, meaningful CONSTANT names? 
       Mark out of 5: 5
   3. Did I format the CONSTANT names properly (in UPPERCASE)? 
       Mark out of 5: 5
   4. Did I use easy-to-understand meaningful variable names? 
       Mark out of 10: 10
   5. Did I format the variable names properly (in lowerCamelCase)? 
       Mark out of 10: 10
   6. Did I indent the code appropriately? 
       Mark out of 10: 10
   7. Did I use an appropriate for loop to test all possibilities?  There should be only one. 
       Mark out of 20:  20
   8. Did I correctly check if people alive today were or could be alive in a year that is the square of their age in that year. 
       Mark out of 30: 30
   9. How well did I complete this self-assessment? 
       Mark out of 5: 5
   Total Mark out of 100 (Add all the previous marks): 100
*/
import java.time.Year;
import java.util.Calendar;

public class YearIsTheQuaeAge {

	public static final int MAX_AGE = 123;

	public static void main(String[] args) {
		
		int currentYear = Calendar.getInstance().get(Calendar.YEAR);
		
		for(int age = 0; age <= MAX_AGE; age++)
		{
			int yearSquareAge = age * age;				
			int yearOfBirth = yearSquareAge - age;
			int ageInCurrentYear =Math.abs(yearOfBirth - currentYear);
			
			if(yearSquareAge >= currentYear - MAX_AGE && yearSquareAge <= currentYear + MAX_AGE 
																	&& ageInCurrentYear <= MAX_AGE && yearOfBirth <= currentYear )
			{				
				System.out.println("If you are " + age + " in " + yearSquareAge 
							+ " your age is the square root of that year. In " + currentYear + " you will be " + ageInCurrentYear); 
					
			}
		}
	}
}

