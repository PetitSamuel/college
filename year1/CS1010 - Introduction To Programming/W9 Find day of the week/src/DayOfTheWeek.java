/* SELF ASSESSMENT
 1. Did I use appropriate, easy-to-understand, meaningful CONSTANT names formatted correctly in UPPERCASE?
        Mark out of 5:  5 // Most constants taken from provided program (except the error message constant)
 2. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)?
        Mark out of 5:  5 // all well formated, names are easy to understand
 3. Did I indent the code appropriately?
        Mark out of 5: 5 //Outputs a given date correctly
 4. Did I define the required function correctly (names, parameters & return type) and invoke them correctly?
       Mark out of 20:  20 //Yes, this  program involves 6 functions, all useful to function properly
 5. Did I implement the dayOfTheWeek function correctly and in a manner that can be understood?
       Mark out of 20:  20 // Yes
 6. Did I implement the other functions correctly, giving credit for any code that you take from elsewhere?
       Mark out of 20:  20 // yes & all credit was given (Constants + Leap year if statements)
 7. Did I obtain (and process) the input from the user in the correct format (dd/mm/yyyy), and deal with any invalid input properly?      
  		Mark out of 10: 10 // program uses '/' as delimiter, in the correct format. If the input is invalid somewhere, an error message is displayed
 8. Does the program produce the output in the correct format (e.g. Monday, 25th December 2017)?
       Mark out of 10: 10, //  Output is correct
 9. How well did I complete this self-assessment?
        Mark out of 5: 5
 Total Mark out of 100 (Add all the previous marks): 100
*/ 

import java.util.Scanner;
import javax.swing.JOptionPane;
public class DayOfTheWeek {
	//using constant values from 'ValideDate.java' program on blackboard
	public static final int DAYS_IN_APRIL_JUNE_SEPT_NOV = 30;
	public static final int DAYS_IN_FEBRUARY_NORMALLY = 28;
	public static final int DAYS_IN_FEBRUARY_IN_LEAP_YEAR = 29;
	public static final int DAYS_IN_MOST_MONTHS = 31;
	public static final int NUMBER_OF_MONTHS = 12;
	public static final String ERROR_MESSAGE = "Error, the input is not valid";
	public static void main(String[] args) {

//taking input, checking if there is a number before assigning them to variables
		String inputDate = JOptionPane.showInputDialog("Enter the date you want using the following form "
																							+ ": (DD/MM/Year).");
		Scanner inputScanner = new Scanner(inputDate);
		inputScanner.useDelimiter("/");
		if(inputScanner.hasNextInt())
		{
			int day = inputScanner.nextInt();
			if(inputScanner.hasNextInt())
			{
				int month = inputScanner.nextInt();
				if(inputScanner.hasNextInt())
				{
					int year = inputScanner.nextInt();
					inputScanner.close();
//checking if date entered is valid
					if(validDate(year, month, day))
					{
//calling functions to build up all the elements for output
					System.out.println(getDayOfTheWeek(day, month, year) + numberString(day) 
																						+ monthString(month) + year);
					}
					else
					{
					System.out.println("Date is not valid");
					}
				}
				else
				{
					System.out.println(ERROR_MESSAGE);
				}
			}
			else
			{
				System.out.println(ERROR_MESSAGE);
			}
		}
		else
		{
			System.out.println(ERROR_MESSAGE);
		}
}
	

public static boolean validDate(int year, int month, int day)
{
return (year >= 0 && day > 0 && day <= daysInMonth(month, year) && month <= NUMBER_OF_MONTHS && month > 0);
}

public static int daysInMonth(int month, int year)
{
	int numberOfDays = 0;
	switch(month)
	{
		case 4:
		case 6:
		case 9:
		case 11:
			numberOfDays = DAYS_IN_APRIL_JUNE_SEPT_NOV;
			break;
		case 2: 
			if(isLeapYear(year))
			{
				numberOfDays = DAYS_IN_FEBRUARY_IN_LEAP_YEAR;
			}
			else
			{
				numberOfDays = DAYS_IN_FEBRUARY_NORMALLY;
			}
			break;
		default:
			numberOfDays = DAYS_IN_MOST_MONTHS;
			break;
	}
	return numberOfDays;
}

public static boolean isLeapYear(int year)
{
//the combination of if/else if statements were taken from the leap year program
	if(year % 400 == 0)
	{
		return true;
	}
	else if(year % 100 == 0)
	{
		return false;
	}
	else if(year % 4 == 0)
	{
		return true;
	}
	else
	{
		return false;
	}
}

public static String monthString(int month)
{
	String monthInCharacters = "";
	switch (month)
	{
	case 1:
		monthInCharacters = "January ";
		break;
	case 2:
		monthInCharacters = "February ";
		break;
	case 3:
		monthInCharacters = "March ";
		break;
	case 4:
		monthInCharacters = "April ";
		break;
	case 5:
		monthInCharacters = "May ";
		break;
	case 6:
		monthInCharacters = "June ";
		break;
	case 7:
		monthInCharacters = "July ";
		break;
	case 8:
		monthInCharacters = "August ";
		break;
	case 9:
		monthInCharacters = "September ";
		break;
	case 10:
		monthInCharacters = "October ";
		break;
	case 11:
		monthInCharacters = "November ";
		break;
	default:
		monthInCharacters = "December ";
		break;
	}
	return monthInCharacters;
}

public static String numberString(int day)
{
	String endingString = Integer.toString(day);
	if(day == 13 || day == 12 || day == 11)
	{
		endingString += "th ";
	}
	else
	{
		int lastDigit = day % 10;
		switch(lastDigit)
		{
		case 1:
			endingString += "st ";
			break;
		case 2:
			endingString += "nd ";
			break;
		case 3:
			endingString += "rd ";
			break;
		default:
			endingString += "th ";
			break;
		}
	}
	return endingString;
}

public static String getDayOfTheWeek(int day, int month, int year)
{
//as said in the formula : if the month is Jan or Feb, Y=Y-1
	String dayString = "";
	if(month == 1 || month == 2)
	{
		year -= 1;
	}
//loop to get last two digits of the year given
	int lastTwoDigitsYear = year;
	while(lastTwoDigitsYear > 99)
	{
		lastTwoDigitsYear = lastTwoDigitsYear % 100;
	};
//loop to get first two digits of the year given	
	int firstTwoYearDigit = year;
	while( firstTwoYearDigit > 99)
	{
		firstTwoYearDigit = firstTwoYearDigit / 10;
	}
//uses the formula given to get a number from 0 to 7, each of which corresponds to a specific day
	int dayOfWeek = (int)Math.abs((day + Math.floor(2.6 * (((month + 9) % 12) + 1) - 0.2) + lastTwoDigitsYear 
										+ Math.floor(lastTwoDigitsYear/4) + Math.floor(firstTwoYearDigit/4) - 2*firstTwoYearDigit)% 7);
//assigns the Characters of the Day to the returned string
	switch(dayOfWeek)
	{
	case 1:
		dayString = "Monday, ";
		break;
	case 2:
		dayString = "Tuesday, ";
		break;
	case 3:
		dayString = "Wednesday, ";
		break;
	case 4:
		dayString = "Thursday, ";
		break;
	case 5:
		dayString = "Friday";
		break;
	case 6:
		dayString = "Saturday, ";
		break;
	default:
		dayString = "Sunday, ";
		break;
	}
	return dayString;
}

}

