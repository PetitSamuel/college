General Instructions:
Use the template files for writing your code and add necessary comments to critical sections of the code.
Write your name next to @author at the beginning of each file
Write the names of people you discussed this assignment with under the @author line. Do not share code and do not write code for others!
You need to adequately test each method in your source code by creating a jUnit test suite.
In certain parts of the assignment where you are asked to answer a question or explain something in particular, add this as a block comment at the beginning of the assignment's main java file.
You can use Java libraries.
the input and output arrays of strings shoud not contain any whitespace characters. For example if you give convertPrefixtoInfix() the input array
{ “+", “*”, “-“, “1”, “2”, “3”, “-“ “10”, “+”, “3”, “/“, “6” “3” }
(I hope I got this right) it should return the array
{ "(", "(", "1", "-", "2", ")", "*", "3", ")", "+", "(", "10", "-", "(", "3", "+", "(", "6", "/", "3", ")", ")", ")", ")” }
which corresponds to the infix expression:
(( 1 - 2 ) * 3) + (10 - (3 + (6 / 3))))
Prefix and Postfix Notation
Prefix notation or Polish notation is a way of unambiguously writing complex arithmetic expressions without the need for parentheses. It was first invented by Jan Łukasiewicz, a Polish mathematician, in 1924.

The main idea is that in prefix notation the operator precedes its operands.

Here we will consider the prefix notation of arithmetic expressions containing integers and the operators for addition (+), subtraction (-), multiplication (*), and integer division (/). Note that all of the operators are binary; that is, they are applied to two operands.

Example 1: ( 1 - 2 ) * 3 can be written as * - 1 2 3 in prefix notation.

Besides being useful in avoiding paretheses, prefix notation is a way of unambiguously representing trees, and for this reason it is commonly used in parsing. In fact the programming language Lisp and all its descedants (e.g., Scheme) only recognise prefix notation.

Postfix notation or Reverse Polish notation is similar, but the operators follow the operands.

Example 2: ( 1 - 2 ) * 3 can be written as 3 1 2 - * in postfix notation.

Notice that an arithmetic expression written in postfix notation is not the reverse string of the same expression in prefix notation.

If we have a sequence of integers and +,-,*,/, characters, how can we decide whether this sequence is a valid prefix arithmetic expression? To validate an arithmetic expression in prefix notation we can use a single counter:

start the counter at 1
read each character of the expression, from left to right
if we read an operator (+,-,*,/) then we increment the counter by one
if we read a number then we decrement the counter by one.
If the counter at the end of the sequence is 0 and it never became negative nor zero during scanning then the sequence is valid. (If the "nor zero" part was missing then the non-valid prefix string "+ 2 3 - 4" would be flagged as valid.)
In a following question you will be asked to come up with an algorithm for validating a prefix notation and implement it in Java.

To evaluate an arithmetic notation in postfix notation we can use a stack.

We scan the expression from left to right.
If we encounter a number we push it to the stack
If we encounter an operator 'p' we pop two items 'n1' and 'n2' from the stack and perform the calculation 'n2 p n1' and push the result back to the stack.
we continue until we scan the entire expression
at the end we pop and return one element from the stack which should be a number and the last element in the stack.
Example 3: Suppose we want to evaluate the postfix expression 3 1 2 - *, using a stack S which is initially empty [ ].

read 3, S.push(3), S=[3]
read 1, S.push(1), S=[1,3]
read 2, S.push(2), S=[2,1,3]
read -, S.pop()=2, S.pop()=1, 1-2=-1, S.push(-1), S=[-1,3]
read *, S.pop()=-1, S.pop()=3, 3*(-1)=-3, S.push(-3), S=[-3]
S.pop()=-3, return -3
Implementation
You need to use the template class in Arith.java to answer the following questions. This is a utility class containing static methods and thus cannot be instantiated. All methods in the class take as an argument an array of strings. You may assume that each string in this array can only be one of the following:

The string representation of an operator: "+", "-", "*", or "/"
The string representation of an integer.
To implement the following methods you may use any data structures from the Java library. However for each method of the Java data structure you use you should research its implementation and running time. This is relevant in the Performance section. You may also implement more data structures and algorithms in the same or separate java files.

Q1: Vaidation
Implement the methods:

public static boolean validatePrefixOrder(String prefixLiterals[])
public static boolean validatePostfixOrder(String prefixLiterals[])
Q2: Evaluation
Implement the methods:

public static int evaluatePrefixOrder(String prefixLiterals[])
public static int evaluatePostfixOrder(String postfixLiterals[])
Q3: Conversion between the two polish notations
Implement the methods:

public static String[] convertPrefixToPostfix(String prefixLiterals[])
public static String[] convertPostfixToPrefix(String postfixLiterals[])
Q4: Conversion to infix notation
Infix notation is the common form of arithmetic operations. Here we will assume it is fully parenthesised; e.g.:

(( 1 - 2 ) * 3) + (10 - (3 + (6 / 3))))

Implement the methods:

public static String[] convertPrefixToInfix(String prefixLiterals[])
public static String[] convertPostfixToInfix(String postfixLiterals[])
Testing
You submission needs to contain a JUnit test file called ArithTest.java that adequatly tests the above methods: every line of code and decision statement should run at least once.

Performance
Q5: Research
At the end of your file you should write a list of data structures you use in your code. For each one of them you should write the list of methods your code calls. For each method you should research its running time and write down appropriate bounds*. You should justify these running times using credible sources and the module material.

In other words, do not use any data structure that you are not certain about its running time!

* It is up to you to understand what "appropriate bounds" means per data-structure/method. You can choose to talk about worst/best/average-case running time, or amortized running time but you need to justify your choice. You can also choose whether you use the asymptotic or approximate notation to report the running times. 

Q6: Estimate the running time of the above methods
Give appropriate bounds for the running time of each method in the Arith class, taking into account the performance of any methods you used. You should write this in comments at the beginning of each of your methods. You should justify these bounds.

Q7: Optimality
Before each method in Q1-Q4 you should argue why you think your implementation is optimal with respect to both time and memory usage.

