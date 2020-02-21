import java.util.Stack;
import static java.lang.Integer.parseInt;

/**
 *  Utility class containing validation/evaluation/conversion operations
 *  for prefix and postfix arithmetic expressions.
 *
 *  @author
 *  @version 1/12/15 13:03:48
 */

public class Arith
{
    //~ Validation methods ..........................................................


    /**
     * Validation method for prefix notation.
     *
     * @param prefixLiterals : an array containing the string literals hopefully in prefix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     *
     * @return true if the parameter is indeed in prefix notation, and false otherwise.
     *
     * Line 39 - 43 executed θ(1) times, execution takes  θ(1) time => T39-43 =  θ(1)
     * Line 44-55 executed  θ(N) times, execution can take: θ(1) or θ(N) (look for explanation above function isNumeric and isStringAnOperator
     * Then, in the worst case we have => T(44-55) = θ(N) * θ(N) = θ(N²)
     * Line 56 executed θ(1) times, execution taking θ(1) time.
     *Total running time (worst case):
     * T(N) = T(39-43) + T(44-55) + T(56) = θ(1) + θ(N²) + θ(1)
     * T(N) = θ(N²)
     * I think this method is optimal as it only loops through the array once and uses a single int
     * with simple increment/decrement statements in order to verify the expression without having to 'simulate' a calculation
     **/
    public static boolean validatePrefixOrder(String prefixLiterals[])
    {
        if(prefixLiterals == null || prefixLiterals.length == 0){
            return false;
        }

        int count = 1;
        for(int i = 0; i < prefixLiterals.length; i++){
            if(Arith.isStringAnOperator(prefixLiterals[i])){
                count++;
            } else if (Arith.isNumeric(prefixLiterals[i])){
                count--;
            } else {
                return false;
            }
            if(count == 0 && i != prefixLiterals.length - 1){
                return false;
            }
        }
        return count == 0;
    }
    /**
     * @param str
     * @return boolean
        Checks if a string is an int or not
        Asymptotic worst case analysis
        Lines 69 to 74 executed θ(N) times, each execution takes θ(1) time
        Line 75 executed once (in worst case), execution taking θ(1) time.
        T(N) = T(69-74) + T(75) = θ(N) + θ(1) = θ(N)
     */
    public static boolean isNumeric(String str)
    {
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            if (c < '0' || c > '9') {
                return false;
            }
        }
        return true;
    }

    /**
     * Checks if a string is an operator or not
     * @param s
     * @return bool
        checks if a string is an operator
        Asymptotic (worst case) analysis:
        both lines are executed θ(1) times, execution takes θ(1)time
        => T(N) = θ(1)
     */
    public static boolean isStringAnOperator (String s){
        char firstChar = s.charAt(0);
        return (firstChar == '+' || firstChar == '-' || firstChar == '*' || firstChar == '/' ) && s.length() == 1;
    }
    /**
     * Validation method for postfix notation.
     *
     * @param postfixLiterals : an array containing the string literals hopefully in postfix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     *
     * @return true if the parameter is indeed in postfix notation, and false otherwise.
     *
     * This algorithm is the same as the one used in validatePrefixOrder()
     * The only difference is that the strings are checked from right to left(instead of left to right)
     * As a result we get the same Asymptotic notation for the worst case as the above method (validatePrefixOrder)
     *
     *  T(N) = θ(N²)
     * I think this method is optimal for the same reasons as 'validatePrefixOrder',
     * It uses a simple int and low cost operations to validate
     **/
    public static boolean validatePostfixOrder(String postfixLiterals[])
    {
        if(postfixLiterals == null || postfixLiterals.length == 0){
            return false;
        }

        int count = 1;
        for(int i = postfixLiterals.length - 1; i >= 0 ; i--){
            if(Arith.isStringAnOperator(postfixLiterals[i])){
                count++;
            } else if (Arith.isNumeric(postfixLiterals[i])){
                count--;
            } else {
                return false;
            }
            if(count == 0 && i != 0){
                return false;
            }
        }
        return count == 0;
    }


    //~ Evaluation  methods ..........................................................


    /**
     * Evaluation method for prefix notation.
     *
     * @param prefixLiterals : an array containing the string literals in prefix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     *
     * @return the integer result of evaluating the expression
     *I think this method is optimal as it only goes through the literals once and copies data from the list as little as possible, using very efficient methods/data structures to do so
     * Asymptotic notation for worst case
     *Line 155 executed θ(1) times, execution taking θ(1) time.
     *Line 156 to 179 executed θ(N) times, execution taking
     * up to θ(N) time (worst case)
     * T(156-179) = θ(N) * θ(N) = θ(N²)
     *Line 180 executed θ(1) time, execution taking θ(1) time
     *T(N) = θ(1) + θ(N²) + θ(1) = θ(N²)
     **/
    public static int evaluatePrefixOrder(String prefixLiterals[])
    {
        Stack<Integer> stack = new Stack<>();
        for(int i = prefixLiterals.length - 1; i>= 0; i--){
            if(Arith.isNumeric(prefixLiterals[i])){
                stack.push(parseInt(prefixLiterals[i]));
            } else if (Arith.isStringAnOperator(prefixLiterals[i])){
                int val1 = stack.pop();
                int val2 = stack.pop();
                int newVal = 0;
                switch (prefixLiterals[i]){
                    case "+":
                        newVal = val1 + val2;
                        break;
                    case "-":
                        newVal = val1 - val2 ;
                        break;
                    case "/":
                        newVal = val1 / val2;
                        break;
                    case "*":
                        newVal = val1 * val2;
                        break;
                }
                stack.push(newVal);
            }
        }
        return stack.pop();
    }


    /**
     * Evaluation method for postfix notation.
     *
     * @param postfixLiterals : an array containing the string literals in postfix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     *
     * @return the integer result of evaluating the expression
     * Same explanation as the above method, I think this method is optimal as it only goes through the literals once and
     * copies data from the list as little as possible, using very efficient methods/data structures to do so .
     *  Algorithm used is the same as the one used in evaluatePrefixOrder with the exception that literals are
     *  evaluated from left to right as opposed to right to left.
     *  As a result the asymptotic notation for the worst case is the same for both methods.
     *  For an explanation of this result please look at the above method
     *  T(N) = θ(N²)
     **/
    public static int evaluatePostfixOrder(String postfixLiterals[])
    {
        Stack<Integer> stack = new Stack<>();
        for(int i = 0; i < postfixLiterals.length; i++){
            if(Arith.isNumeric(postfixLiterals[i])){
                stack.push(parseInt(postfixLiterals[i]));
            } else if (Arith.isStringAnOperator(postfixLiterals[i])){
                int val1 = stack.pop();
                int val2 = stack.pop();
                int newVal = 0;
                switch (postfixLiterals[i]){
                    case "+":
                        newVal = val1 + val2;
                        break;
                    case "-":
                        newVal = val2 - val1;
                        break;
                    case "/":
                        newVal = val2 / val1;
                        break;
                    case "*":
                        newVal = val1 * val2;
                        break;
                }
                stack.push(newVal);
            }
        }
        return stack.pop();
    }


    //~ Conversion  methods ..........................................................


    /**
     * Converts prefix to postfix.
     *
     * @param prefixLiterals : an array containing the string literals in prefix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     *
     * @return the expression in postfix order.
     * In my opinion this algorithm is efficient as it only loops through the list once
     * It build the output as the loop goes rather than doing so in multiple operations
     * The amount of duplicated data is as low as possible
     * Asymptotic notation for worst case
     * Line 258 executed θ(1) times with θ(1) execution time
     * Lines 259 to 280 executed θ(N) times with execution time of θ(1) => T(259-280) = θ(N)
     * Line 280 executed θ(1) times with execution time of θ(1)
     * Total :
     * T(N) = θ(1) +  θ(N) + θ(1)
     * T(N) = θ(N)
     **/

    public static String[] convertPrefixToPostfix(String prefixLiterals[])
    {
        Stack<String> stack = new Stack<>();
        for (int i = prefixLiterals.length - 1; i >= 0; i--) {

            // current string is an operator
            if (Arith.isStringAnOperator(prefixLiterals[i])) {

                // pop values to apply operator to from stack
                String op1 = stack.pop();
                String op2 = stack.pop();

                // create space separated string from operator and both values
                String tmp = op1 + " " + op2 + " " + prefixLiterals[i];

                // Push to stack
                stack.push(tmp);
            }

            // current string is a number
            else {
                // push to stack
                stack.push(prefixLiterals[i]);
            }
        }
        return stack.pop().split(" ");
    }


    /**
     * Converts postfix to prefix.
     *
     * @param postfixLiterals : an array containing the string literals in postfix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     * @return the expression in prefix order.
     * Algorithm used is the same as the one used in convertPrefixToPostfix with the exception that literals are
     *      *  evaluated from left to right as opposed to right to left.
     *      *  As a result the asymptotic notation for the worst case is the same for both methods.
     *      *  For an explanation of this result please look at the above method
     *      *  T(N) = θ(N)
     * As a result the explanation is the same as the above method as well: In my opinion this algorithm is efficient as it only loops through the list once
     * It build the output as the loop goes rather than doing so in multiple operations The amount of duplicated data is as low as possible
     **/
    public static String[] convertPostfixToPrefix(String postfixLiterals[])
    {
        Stack<String> stack = new Stack<>();

        // from left to right
        for (int i = 0; i < postfixLiterals.length; i++) {

            // operator
            if (Arith.isStringAnOperator(postfixLiterals[i])) {

                // pop from stack
                String val1 = stack.pop();
                String val2 = stack.pop();

                // make space separated string from operator and popped values
                String tmp = postfixLiterals[i] + " " + val2 + " " + val1;

                // Push string temp back to stack
                stack.push(tmp);
            }

            // an int
            else {

                // push to stack
                stack.push(postfixLiterals[i]);
            }
        }
        // pop expression from stack and split to return array
        return stack.pop().split(" ");
    }

    /**
     * Converts prefix to infix.
     *
     * @param prefixLiterals : an array containing the string literals in prefix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     * @return the expression in infix order.
     * Strategy used to convert is similar to above, In my opinion this algorithm is efficient as it only loops through the list once
     * It build the output as the loop goes rather than doing so in multiple operations The amount of duplicated data is as low as possible
     * Asymptotic notation for worst case
     * Line 353 executed θ(1) times with execution time of θ(1)
     * Lines 356 to 378 executed θ(N) times with execution time of θ(1) => T(356-378) = θ(N)
     * Line 379 executed θ(1) times with execution time of θ(1)
     * Total :
     * T(N) = θ(1) +  θ(N) + θ(1)
     * T(N) = θ(N)
     **/
    public static String[] convertPrefixToInfix(String prefixLiterals[])
    {
        Stack<String> stack = new Stack<>();

        // from right to left
        for (int i = prefixLiterals.length - 1; i >= 0; i--) {

            // check if symbol is operator
            if (Arith.isStringAnOperator(prefixLiterals[i])) {

                // pop from stack
                String val1 = stack.pop();
                String val2 = stack.pop();

                // create space separated string from operator and values
                String tmp = "( " + val1 + " " + prefixLiterals[i] + " " + val2 + " )";

                // Push string temp back to stack
                stack.push(tmp);
            }
            // int
            else {

                // push to stack
                stack.push(prefixLiterals[i]);
            }
        }
        // pop result from stack and split into array
        return stack.pop().split(" ");
    }

    /**
     * Converts postfix to infix.
     *
     * @param postfixLiterals : an array containing the string literals in postfix order.
     * The method assumes that each of these literals can be one of:
     * - "+", "-", "*", or "/"
     * - or a valid string representation of an integer.
     * @return the expression in infix order.
     * Strategy used to convert is similar to above, In my opinion this algorithm is efficient as it only loops through the list once
     * It build the output as the loop goes rather than doing so in multiple operations The amount of duplicated data is as low as possible
     * Algorithm used is the same as the one used in convertPrefixToInfix with the exception that literals are
     * evaluated from left to right as opposed to right to left.
     * As a result the asymptotic notation for the worst case is the same for both methods.
     * For an explanation of this result please look at the above method T(N) = θ(N)
     **/
    public static String[] convertPostfixToInfix(String postfixLiterals[])
    {
        Stack<String> stack = new Stack<>();

        for (int i=0; i < postfixLiterals.length; i++)
        {
            // string is an operator, push built string to stack
            if (Arith.isStringAnOperator(postfixLiterals[i]))
            {
                String val1 = stack.pop();
                String val2 = stack.pop();
                stack.push("( " + val2 + " " + postfixLiterals[i] + " " + val1 + " )");
            } else {
                // string is an int, push to stack
                stack.push(postfixLiterals[i]);
            }
        }
        // pop result expression from stack, split to make array
        return stack.pop().split(" ");
    }
}

/*
Q5 : research
Data structures used in my code : Stack
methods used: pop, push.
Running times :
Push: O(1)
Pop: O(1)
There is a constant k such that k is the constant running time in nanoseconds for the push method (same for pop)
    source : https://www.cs.cmu.edu/~adamchik/15-121/lectures/Stacks%20and%20Queues/Stacks%20and%20Queues.html
 */