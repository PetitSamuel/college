General Instructions:
Use the template files for writing your code and add necessary comments to critical sections of the code.
Write your name next to @author at the beginning of each file
Write the names of people you discussed this assignment with under the @author line. Do not share code and do not write code for others!
You need to adequately test each method in your source code by adding sufficient jUnit tests to the ones provided.
In certain parts of the assignment where you are asked to answer a question or explain something in particular, add this as a block comment at the beginning of the assignment's main java file.
Do not import data structures from the java libraries.
The submission server for this assignment will open shortly.
Binary Search Trees
You will implement some operations on binary trees in the template file BST.java. The file already contains methods to insert key-value pairs and search for a key in binary search trees. You need to Implement the following public methods recursively, adding one private recursive method for each public method:

public int height(): returns the height of the tree. For this method you also need to write in comments the worst-case asymptotic running time of this method as a function of the number of keys N in the tree, and briefly explain it.
public Key median(): returns the median key in the tree.
if the tree is empty the method should return null.
If the tree has N keys K0 < K1 < K2 < ... < K(N-1), then their median is key K((N-1)/2) (here "/" is integer division). Note that the median is always a key, not the average of keys. If there is an even number of keys. For example if the keys in the tree are the A, C, U, W then the median is the key at position (4-1)/2=1, which is key C -- position numbers start at zero.
This operation needs to run in worst-case Θ(h) time, where h is the height of the tree.
Hint: To implement a Θ(h) median method you need to study and understand the rank and select methods from the lectures  and the book.
public void delete(Key key): deletes from the tree the node containing key.  
Your implementation needs to be different than the Hibbard deletion from the lectures: if the node to be deleted has two child nodes, then it needs to be replaced with its predecessor (not its successor). The predecessor of a key in a BST is the immediately smaller key. In the book & lectures we saw the Hibbard deletion algorithm which makes use of the successor of a key (the immediately larger key). In the example BST at the bottom of the page, the predecessor of key E is C, and the successor of E is H.
public String printKeysInOrder(): returns a String containing all keys (but not the associated values) in the tree, in order (this is an inorder traversal of the tree). This means that for every node N, the keys in its Left Subtree are printed first, then the key in node N is printed, and then the keys in the Right Subtree are printed. (Also: review the inorder/preorder/postorder traversals.) The keys in each subtree should be contained in a pair of parentheses. For example when you call this method with an empty tree it should return the empty string "()". When you call it with the tree containing only a single key "A", it should return "(()A())". When you call this method on the tree in the picture below it should return the string "(((()A(()C()))E((()H(()M()))R()))S(()X()))". There are more examples in the comments before the method in BST.java.
public String prettyPrintKeys(): This method returns a multi-line string representation of a tree, showing only the keys in the tree. This representation should
print the key of each node in a separate line
print null nodes
print the left subtree before the right subtree
use correct indentation to print the example below.
Note that this is a preorder traversal of the tree. When the method is called with an empty tree, it should return the string "-null\n".
When the method is called with the example tree shown in the picture below, it should return the string:

-S
 |-E
 | |-A
 | | |-null
 | |  -C
 | |   |-null
 | |    -null
 |  -R
 |   |-H
 |   | |-null
 |   |  -M
 |   |   |-null
 |   |    -null
 |    -null
  -X
   |-null
    -null
Note that line breaks in a string are represented with the special sequence "\n". You should have a "\n" even after the last key in the tree.

Hint: To implement this method you should use an inner recursive method:

private String prettyPrint(Node<Key,Value> node, String prefix)

where the argument prefix is the string before horizontal dash "-". In the above example, the prefix when this method is called for the node containing H is: " " + "|" + " " + " " + " " + "|".

You should add tests in the file BSTTest.java to sufficiently test all the functionality of your code. Your tests should execute each line of code at least once and they should exercise the decision-branches of every if-then-else statement and loop statement. The submission server will automatically test for this.

Time spent on the assignment
Input the hours you spent on this assignment. The input is anonymous and will only be used for statistics. Please try to be as accurate as possible.

Example Tree, showing only keys:
