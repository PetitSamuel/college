/* SELF ASSESSMENT 
   1. Did I use appropriate CONSTANTS instead of numbers within the code? 
       Mark out of 5: 5
       Only appropriate constant is how many verses are in the song
   2. Did I use easy-to-understand, meaningful CONSTANT names formatted correctly in UPPERCASE? 
       Mark out of 5: 5 only one, name is very easy to understand
   3. Did I use easy-to-understand meaningful variable names formatted properly (in lowerCamelCase)? 
       Mark out of 10: 10 format is correct and names are clear & easy to understand
   4. Did I indent the code appropriately? 
       Mark out of 10: 10 Yes, it does what it is supposed to do
   5. Did I use an appropriate loop (or loops) to produce the different verses? 
       Mark out of 20:  20 2 loops, one for and one switch in order to print out all the lyrics.
   6. Did I use a switch to build up the verses? 
       Mark out of 25: 25 Yes
   7. Did I avoid duplication of code and of the lines which make up the verses (each line should be referred to in the code only once (or twice))? 
       Mark out of 10:  10 Only once
   8. Does the program produce the correct output? 
       Mark out of 10:  10 Yes
   9. How well did I complete this self-assessment? 
       Mark out of 5: 5 
   Total Mark out of 100 (Add all the previous marks): 100
*/

public class TwelveDaysOfXmas {

	public static final int TOTAL_VERSES = 12;
	
	public static void main(String[] args) {
		
		String lyrics = "";
		for(int verse = 1; verse <= TOTAL_VERSES; verse++ )
		{
			String day = (verse == 1)? "first" : (verse == 2)? "second" : (verse == 3)
															? "third" : (verse == 4)? "fourth" : (verse == 5)? "fifth" :
															(verse == 6)? "sixth" : (verse == 7)? "seventh" : (verse == 8)
															? "eighth" : (verse == 9)? "nineth" : (verse == 10)? "tenth" 
															: (verse == 11)? "eleven" : (verse == 12)? "twelveth" : "error in program";
			String firstLine = "On the " + day + " day of christmas my true love sent to me\n"; 
			
			switch(verse)
			{
				case 1 :
					lyrics = "A partridge in a pear tree \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 2 : 
					lyrics = "Two turtle doves and \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 3 : 
					lyrics = "Three French hens \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 4 : 
					lyrics = "Four colly birds \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 5 : 
					lyrics = "Five gold rings \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 6 : 
					lyrics = "Six geese laying \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 7 : 
					lyrics = "Seven swans swimming \n" + lyrics;
					System.out.println(firstLine + lyrics);
					break;
				case 8 : 
					lyrics = "Eight maids milking \n" + lyrics;
					System.out.println(firstLine + lyrics);					
					break;
				case 9 : 
					lyrics = "Nine drummers drumming \n" + lyrics;
					System.out.println(firstLine + lyrics);					
					break;
				case 10 : 
					lyrics = "Ten pipers piping \n" + lyrics;
					System.out.println(firstLine + lyrics);					
					break;
				case 11 : 
					lyrics = "Eleven ladies dancing \n" + lyrics;
					System.out.println(firstLine + lyrics);					
					break;
				case 12 : 
					lyrics = "Twelve lords leaping \n" + lyrics;
					System.out.println(firstLine + lyrics);					
					break;
				default : 
					System.out.println("Error in code");				
			}
		}	
	}
}
