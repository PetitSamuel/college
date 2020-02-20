/*  SELF ASSESSMENT
   1. Did I use appropriate CONSTANTS instead of numbers within the code?
       Mark out of 10: 10  
   2. Did I use easy-to-understand, meaningful CONSTANT names?
       Mark out of 5: 5
    3. Did I format the CONSTANT names properly (in UPPERCASE)?
       Mark out of 5:  5
   4. Did I use easy-to-understand meaningful variable names?
       Mark out of 10: 10 
   5. Did I format the variable names properly (in lowerCamelCase)?
       Mark out of 10:  10
   6. Did I indent the code appropriately?
       Mark out of 10:  9
   7. Did I read the input correctly from the user using (an) appropriate question(s)?
       Mark out of 10:  9
   8. Did I compute the answer correctly for all cases?
       Mark out of 20:  10
   9. Did I output the correct answer in the correct format (as shown in the examples)?
       Mark out of 10:  10
   10. How well did I complete this self-assessment?
       Mark out of 10:  9
   Total Mark out of 100 (Add all the previous marks): 97 
*/
import java.util.Scanner;

import javax.swing.JOptionPane;

import java.text.DecimalFormat;

public class ConvertingOldPoundsToNewPounds {

	public static final int NEW_PENNIES_PER_OLD_PENNY = 67;
	public static final int NEW_PENNIES_PER_OLD_SHILLING = 12* NEW_PENNIES_PER_OLD_PENNY;
	public static final int NEW_PENNIES_PER_OLD_POUND = 20 * NEW_PENNIES_PER_OLD_SHILLING;
	public static final double PENNIES_PER_POUND = 100.00;

	public static void main(String[] args) {
		

		String inputOldMonney = JOptionPane.showInputDialog
				("Enter the amount of old Pounds, Shillings and "
				+ "Pennies you wish to convert in this same order, "
				+ "separated by spaces");
		Scanner inputScanner = new Scanner(inputOldMonney);
		int oldPounds = inputScanner.nextInt();
		int oldShillings = inputScanner.nextInt();
		int oldPennies = inputScanner.nextInt();
		inputScanner.close();
		
		double totalInNewPounds = (oldPounds * NEW_PENNIES_PER_OLD_POUND 
				+ oldShillings * NEW_PENNIES_PER_OLD_SHILLING + oldPennies 
				* NEW_PENNIES_PER_OLD_PENNY)/PENNIES_PER_POUND;
		DecimalFormat decimalFormat = new DecimalFormat("#0.00");
		JOptionPane.showMessageDialog(null, oldPounds +" old pound, " 
				+ oldShillings + " old shilling and " + oldPennies 
				+ " old pence =  £" + decimalFormat.format(totalInNewPounds));
	}
}


