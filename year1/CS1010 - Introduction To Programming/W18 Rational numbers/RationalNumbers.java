/* SELF ASSESSMENT

Class Retional
I declared two member variables: numerator and denominator (marks out of 4:4 ).
Comment:Numerator and denominator

Constructor 1
My program takes take two integers as parameters (for numerator and denominator) and initialises the member variables with the corresponding values . If the denominator is equal to 0 I throw an exception (marks out of 5:5 ).
Comment: does all of the above & does check if one or more denominators are 0 (NOTE : done outside of the constructor)

Constructor 2
My program takes only one integer as parameter (numerator), and set the numerator to this value . I set the denominator to 1 in this case, as the resulting rational number in this case is an integer (marks out of 3:3).
Comment: Constructor exists, I never used it though

Add Method
My program takes only a rational number as a parameter and returns a new rational number which has a numerator and denominator which the addition of the two objects - this and the parameter. My program does not overwrite any of the other two rational numbers (marks out of 8:8).
Comment: perfoms a fraction addition (first makes both numbers to the same denominator, does the addition and simplifies the answer in the constructor). It does create a new Rational object

Subtract Method
I have implemented this the same as add method, except it implements subtraction (marks out of 8:8).
Comment:exactly the same as add but subtracts the numerators

Multiply Method
I have implemented this the same as add method, except it implements multiplication (marks out of 8:8).
Comment: multiplies both numerators and denominators and creates a new rational object

Divide Method
I have implemented this the same as add method, except it implements divide (marks out of 8:8).
Comment:same as multiplication but multiplies by the inverse to make the division.

Equals Method
My program takes a rational number as a parameter and compares it to the reference object. I only use multiplication between numerators/denominators for the purpose of comparison, as integer division will lead to incorrect results. I return a boolean value ((marks out of 8: ).
Comment: compares both rational numbers converted to have the same denominator. Takes a rational number to compare it with the reference rational. Returns a boolean

isLessThan
My program takes a rational number as a parameter and compares it to the reference object. I only use multiplication as integer division will lead to incorrect results. I return a boolean value (marks out of 8:8).
Comment:Same as equal but checks if the reference rational is less than the parameter rational

Simplify Method
My program returns a rational number but not a new rational number, instead it returns the current reference which is this.
It doesn't take any parameters as it works only with the reference object.
 I first find the greatest common divisor (GCD) between the numerator and denominator, and then obtain the new numerator and denominator by dividing to the GCD (marks out of 8: 8).
Comment: is a void and changes this.numerator and this.denominator. Calls GDC to find the greatest common divisor and simplifies the numerators/denominators accordingly.
 Also checks for the case that if both the numerator and denominator are negative numbers then the negative signs are cancelled. And if only the denominator is negative, that sign is placed on
 the numerator.

gcd function
My program returns the greatest common divider of two integers: the numerator and the denominator (marks out of 6:6).
Comment: returns the greatest integer that divides both parameters

toString Method
My program returns a string showing the fraction representation of the number, eg. "1/2". It takes no parameters (marks out of 4:4).
Comment: outputs a string that represents the fraction of the rational numbers

Test Client Class
My program asks the user for two rational numbers, creates two rational objects using the constructor and passing in the provided values, calls addition, subtraction, multiplication, division, comparison and simplification and prints out the results (marks out of 22:22).
Comment: my program does all the above but will not support if the user wishes to input an integer (and therefore doesn't provide a denominator value)
-> it will only work if 4 number inputs are provided.
Other than that, does all of the above.
*/

package BankS2.rationalPack;

import java.util.ArrayList;
import java.util.Scanner;

public class RationalNumbers {
    public static String[] ORDER_KEYWORDS = {"addition: ", "subtraction: ", "multiplication: ", "division: "};

    public static void main(String[] args) {
        Scanner input = null;
        boolean finished = false;
        while(!finished){
            System.out.println("Enter two sets of numerators and denominators (ex : 1, 5, 10, 3 to get 1/5 and 10/3)." +
                                        "\nTo enter an integer use a denominator of 1. Enter 'exit' to stop the program.");
            input = new Scanner(System.in);
            if(input.hasNext("exit")){
                finished = true;
                System.out.println("The program has ended.");
            }
            else if (input.hasNextLine()) {
                String numbersInput = input.nextLine();
                String[] numberInput = readString(numbersInput);
                if (numberInput.length == 4) {
                    int[] numeratorsAndDenominators = getIntValues(numberInput);
                    if (numeratorsAndDenominators != null && (numeratorsAndDenominators[1] != 0 && numeratorsAndDenominators[3] != 0)) {
                        Rational fraction1 = new Rational(numeratorsAndDenominators[0], numeratorsAndDenominators[1]);
                        Rational fraction2 = new Rational(numeratorsAndDenominators[2], numeratorsAndDenominators[3]);
                        ArrayList<Rational> rationalList = new ArrayList<Rational>();
                        rationalList.add(fraction1.add(fraction2));
                        rationalList.add(fraction1.subtract(fraction2));
                        rationalList.add(fraction1.multiply(fraction2));
                        if (fraction2.getNumerator() != 0) rationalList.add(fraction1.divide(fraction2));
                        else System.out.println("The numerator of the divisor is 0 therefore, divising is not possible.");
                        if (fraction1.equals(fraction2))
                            System.out.println(fraction1.toString() + " and " + fraction2.toString() + " are equal");
                        else if (fraction1.isLessThan(fraction2))
                            System.out.println(fraction1.toString() + " is less than " + fraction2.toString());
                        else System.out.println(fraction2.toString() + " is less than " + fraction1.toString());
                        printList(rationalList);
                    } else {
                        System.out.println("Error in one of the inputs. One of the denominators may be 0\n");
                    }
                } else {
                    System.out.println("ERROR : More or less than 4 numbers were entered.\n");
                }
            }
        }
    }

    public static String[] readString(String numbersString) {
        String[] stringLineToArray = numbersString.split(",");
        for (int i = 0; i < stringLineToArray.length; i++) {
            stringLineToArray[i] = stringLineToArray[i].trim();
        }
        return stringLineToArray;
    }

    public static int[] getIntValues(String[] array) {
        int[] numbers = new int[array.length];
        try {
            for (int i = 0; i < array.length; i++) {
                numbers[i] = Integer.parseInt(array[i]);
            }
            return numbers;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public static void printList(ArrayList<Rational> list) {
        for (int i = 0; i < list.size(); i++) {
            System.out.println("Result of the " + ORDER_KEYWORDS[i] + list.get(i).toString() + ((i == list.size() -1)?"\n":""));
        }
    }
}