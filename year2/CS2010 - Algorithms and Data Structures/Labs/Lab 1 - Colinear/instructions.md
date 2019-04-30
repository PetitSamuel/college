Lab 1
Perform parts 1, 2 and 6 first in lab. Then continue with parts 3, 4 and 5. Attendance will be taken once you complete at least parts 1, 2, 6, and 3. All parts should be finished by next week.

1. Download:

Collinear.java: a java file with empty methods that you will have to implement.
CollinearTest.java: where you need to add jUnit tests and experiments.
2. Compilation:
2.1. In Eclipse:
Create a new Java Project
Import the above Collinear.java into the project
Create a new jUnit test named CollinearTest.java by following the instructions on this tutorial. This will add the necessary jUnit packages in your project's classpath.
Replace the source of CollinearTest.java created in Eclipse with the contents of the file CollinearTest.java you downloaded above.
Consult the jUnit tutorial to see how to run the tests.
2.2 In the Command Line (optional):
If you want to use your own editor and compile the assignment in the command line then you will need to download some additional files.

In the same directory as the above source files, download the packages hamcrest-core-1.3.jar and junit-4.11.jar, and the Java file TestRunner.java
From the command line, to compile type: javac -cp junit-4.11.jar *.java
To run the compiled code type: java -cp hamcrest-core-1.3.jar:junit-4.11.jar:. TestRunner
If no output is printed then all tests have passed. Any test that fails will print a descriptive line.
3. Implementation:
Write the code for the three stub methods in Collinear.java.

static int countCollinear(int[] a1, int[] a2, int[] a3)
static int countCollinearFast(int[] a1, int[] a2, int[] a3)
static boolean binarySearch(int[] a, int x)
static void sort(int[] a)
The first two methods count the number of sets of 3 points in a1, a2, a3 which are collinear (they lie on the same line) but do not lie on a horizontal line. The other two are binary search and insertionSort needed for the efficient implementation of countCollinearFast.

The paramenters a1, a2 and a3 contain the x-coordinates of points on the horizontal lines y=1, y=2 and y=3, respectively. For example a1[i] (for some i) represents the point (a1[i], 1); a2[i] represents the point (a2[i], 2), etc.

We are looking for 3 points in a1, a2, a3 which lie on the same line. There are two possibilities: all three points lie on the same horizontal line (y=1, y=2, or y=3) and therefore they are all in the same array, or they lie on a non-horizontal line.

We want to count how many sets of 3 points in a1, a2, a3 are collinear and lie on a non-horizontal lines. Such a non-horizontal line will have to cross all three of the lines y=1, y=2, y=3, and thus the three collinear points will need to be one from each of the 3 arrays. Here is an example.

Three points (x1, y1), (x2, y2), (x3, y3) are collinear (i.e., they are on the same line) if

x1*(y2−y3) + x2*(y3−y1) + x3*(y1−y2)=0
where y1=1, y2=2, y3=3.

Therefore, the first two methods you need to implement return the number of triples (i,j,k) for which the above equation holds for the points (a1[i], 1), (a2[j], 2), (a3[k], 3).

countCollinear should follow a brute-force approach. It should look for collinear triples trying out all combinations of 3 numbers from the three arrays.

countCollinearFast should implement the same functionality, but with a significantly more efficient algorithm. You should come up with such an algorithm making use of binary search  and insertion sort. 

You need to implement Binary Search. The implementations should be correct and of the appropriate running time. 

InsertionSort is a method that sorts an array and is already implemented in the file. The order of growth of this running time is N^2.

Note: Please do not place your code in a custom java package. This means that in the beginning of your java file you should not have a "package ..." statement. In Eclipse this means that you should place your code in the default package. If your files have a package statement you will see this error in the results page and receive a 0 score.

4. Testing:
By reading the source code of Collinear.java and the above jUnit tutorial you should be in a position to extend the testsuite with more test cases. In case of complications please talk to the demonstrators in your lab.

Sufficient testing and Correctness are marked in this assignment (more on this below).

Your goal is to write enough tests so that 

Each method in Collinear.java is tested at least once,
Each decision (that is, every branch of if-then-else, for, and other kinds of choices) in Collinear.java is tested at least once,
Each line of code in Collinear.java is executed at least once from the tests.
The submission server will analyse your tests and code to determine if the above criteria have been satisfied.

NOTE: If your code has the pattern

if (condition 1)
{...}
else if (condition 2)
{...}
else if (condition 3)
{...}
Then most probably by the time the last condition (condition 3) is reached, it will always be true (because conditions 1 and 2 being false imply that condition 3 is true). The submission server will complain that you have not tested the line containing condition 3. This in fact means that the 'else' case of the if (condition 3) was never tested. You can get rid of the error by changing the above code to:

if (condition 1)
{...}
else if (condition 2)
{...}
else // if (condition 3)
{...}
That is, comment out the last if.

 

5. Performance:
5.1 Calculate the Order of Growth of the Running Time
For all methods in class Collinear write in comments the order of growth of the worst-case performance of these methods. You should explain your answer.

6. Submission and Automatic Marking:
6.1 Log in to the Submission Server:
The server is only accessible from within TCD. You will not be able to submit your assignment from home. You should not consider the submission as a repository of your code. Always keep you own copy of your assignments.

Log in to this link using as username and password given to you in the labs. If you have not registered yet speak to the TA to get a username for this system.
Change your password: once you log in click on your Student Number on the top-right corner and choose a new password in the appropriate fields; then click save. NOTE: passwords are stored as plain text! Do not choose a password you use elsewhere (e.g. in other TCD machines or your bank account)!! Write the password down if you have to. Please do not change your name or email on the submission server.
6.2 Upload your assignment
You can only upload a single zip, jar, tar, or tgz file. This file should contain only your modified Collinear.java and CollinearTest.java. Please do not include any other files because it might result in losing marks.

However, you can upload new versions of your assignment as many times as you want until the assignment deadline.

To upload your assignment:

From the home screen, click "Upload" under "Assignment 1"
Choose your compressed file and click "Upload Submission"
Confirm that the zip contains only the two java files discussed above.
Your assignment submission is now in a queue, waiting to be compiled and tested with your tests and a number of hidden "Release" tests
Once tested, you will be directed to a Results screen explaining your score. You can reach this screen by the "Latest Results" button on your home screen.
6.3 Explanation of the results:
There is a lot of information in the results. The most important is:

Your total score (in this assignment is equal to 50% of your Correctness/Testing score + 50% of manual score given later by the demonstrators.)
Section "File Details": here you can see annotated versions of your code. Hover the mouse over the red lines to see the remarks of the automatic grading process. These might be that a method/line/condition has not been tested in your Collinear.java file -- this means that you need to write more tests targeting these points in the code. Red lines with the remark "lines not tested" in the Collinear.java file mean that tests have failed -- you need to understand why and fix them.
Section "Results from running your tests" contains the tests that failed (annotated with a small red X) and those that succeeded, annotated with a green tick.
Section "Coverage" informs you about the percentage of methods/lines/conditionals you tested.
"Estimate of problem coverage" will be less than 100% if the hidden release tests fail but your own tests don't. This means that the release tests have discovered a bug that your tests haven't. Failed hidden tests will give you a hint on what went wrong.
"Interpreting your Correctness/Testing Score" explains the formula computing your final score. Rounding and difference in decimal points might make this seem incorrect, but it's only because the final score is more precise.
It's always a good idea to save a "Full Printable Report" together with your assignment for your own records (and for backup).
A webcast video shows the process of submitting an assignment in more detail. However the software shown there may be a slightly older version.

jUnit is a useful tool to use in all your Java projects. We will certainly keep using it in this module. Please read this online article to familiarise yourself with it more.

 