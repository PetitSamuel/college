General Instructions:
Keep track of the time you spend for this assignment (in and out of labs). You will be asked for this at the end of this text.
Use the template files for writing your code and add necessary comments to critical sections of the code.
Write your name next to @author at the beginning of each file
Write the names of people you discussed this assignment with under the @author line. Do not share code and do not write code for others!
You need to adequately test each method in your source code by adding sufficient jUnit tests to the those provided.
In certain parts of the assignment where you are asked to answer a question or explain something in particular, add this as a block comment at the beginning of the assignment's main java file.
Do not import data structures from the java libraries. This will result in a heavy point penalty!
There is a visualisation of the doubly-linked list methods which shows what needs to be implemented in Part 1 of this assignment.
Generic Data Structures in Java
Review the lecture notes about Java Generics. 

In this assignment we will use the following implementation of a generic class of nodes of the Doubly Linked List in Part 1:

/**
* Class DoublyLinkedList: implements a *generic* Doubly Linked List.
* @param <T> This is a type parameter. T is used as a class name in the
* definition of this class.
*
* When creating a new DoublyLinkedList, T should be instantiated with an
* actual class name that extends the class Comparable.
* Such classes include String and Integer.
*
* For example to create a new DoublyLinkedList class containing String data:
*    DoublyLinkedList<String> myStringList = new DoublyLinkedList<String>();
*
* The class offers a toString() method which returns a comma-separated sting of
* all elements in the data structure.
*
* This is a bare minimum class you would need to completely implement.
* You can add additional methods to support your code. Each method will need
* to be tested by your jUnit tests -- for simplicity in jUnit testing
* introduce only public methods.
*/
class DoublyLinkedList<T extends Comparable<T>>
The above definition has a peculiarity: the parameter of the DLLNode is T extends Comparable<T>, which is called a bounded type parameter. This tells the java compiler that we only want to instantiate the DLLNode class with a parameter class that implements the Comparable interface. Because the comparable interface is itself generic, we have to specify that the classes we want to allow in the place of T here are those whose objects can be compared with other objects of the same class; i.e., we want a class T containing a method int compareTo(T o).

Doubly Linked List
A doubly linked list (DLL) is a data structure maintaining a sequence of elements, similar to a linked list data structure. The difference is that in a DLL from each element in the sequence we can move to the previous and next element with a Θ(1) operation. This is achieved by maintaining in each node of the DLL two references: one to the previous node and one to the next node (the prev and next fields of the DLLNode class). Doubly linked lists have been discussed in the lectures.

Question 1: DLL implementation (80 marks)
Here you need to implement the methods in DoublyLinkedList.java. This class stores a doubly linked list of DLLNode objects.

    /**
     * private class DLLNode: implements a *generic* Doubly Linked List node.
     */
    private class DLLNode
    {
        public final T data;
        public DLLNode next;
        public DLLNode prev;
    
        /**
         * Constructor
         * @param theData : data of type T, to be stored in the node
         * @param prevNode : the previous Node in the Doubly Linked List
         * @param nextNode : the next Node in the Doubly Linked List
         * @return DLLNode
         */
        public DLLNode( T theData, DLLNode prevNode, DLLNode nextNode ) 
        {
          data = theData;
          prev = prevNode;
          next = nextNode;
        }
    }
Each DLLNode object has three fields, a data field of type T, a reference (prev) to the previous node in the list and a reference (next) to the next node in the list. The data field is final, meaning that once set by the constructor it should never change.

The DoublyLinkedList class has two important fields:

private DLLNode head, tail;
The first (head) is a reference to the first element of the list and the other (tail) is a reference to the last element of the list. These fields are initialised to null when an object of the class is constructed.

If the list is empty then both head and tail are null. If the list is non-empty then both head and tail are not null. There is no situation where only one of these fields is null.

If the list contains one element then head and tail reference this same element.

All insert and delete operations need to properly update the head and tail fields. They also need to properly update the .prev and .next fields in the nodes of the list.

isEmpty(): returns true if the list is empty and false otherwise.
insertBefore(int pos, T data): inserts data before the element in the i-th position in the list. The first element in the list (head) is at position 0. If pos is less than 0 then add to the head of the list. If pos is greater or equal to the size of the list then add the element at the end of the list.
get(int pos): returns the element at position pos (the head is at position 0) if pos is within the bounds of the list. If pos is negative of too large it returns null.
deleteAt(int pos): deletes element at position pos in the list (the head is at position 0) if pos is within the bounds of the list. It returns true if a deletion was performed.
reverse(): reverses the list.
makeUnique(): this method should remove all duplicate elements from the list. It should run in O(N^2) where N is the number of elements in the list. It should also preserve the original order of elements in the list.
Your code will be marked for correctly implementing and adequately testing the above methods. Download the jUnit test file DoublyLinkedListTest.java and add more tests in it so that every method, line of code and if-then-else branch is tested at least once.

Question 2: Stack & Queue (20 marks)
Implement the push and a pop methods in the class such that if only these two methods are called, an object of the class would behave like a stack.

Implement the enqueue and dequeue methods in the class such that if only these two methods are called, an object of the class would behave like a FIFO queue.

Question 3: Asymptotic worst-case running time (100 marks)
For each method in the file DoublyLinkedList.java add a comment at the beginning of the method stating the asymptotic worst-case running time of that method and justify your answer. Each basic operation may be assumed to take Theta(1) time to execute. Also, calls to Java methods may be assumed to take Theta(1) time. However, the execution of calls to methods you have implemented will take the time you have calculated for these methods. See the toString() method already implemented in the file for an example.

Question 4: Time spent on the assignment
Input the hours you spent on this assignment. The input is anonymous and will only be used for statistics. Please try to be as accurate as possible.