// -------------------------------------------------------------------------
/**
 *  This class contains the methods of Doubly Linked List.
 *
 *  @author Samuel Petit (haven't disscussed or share code for this assignment)
 *  @version 01/10/18 17:35:49
 */


import java.util.ArrayList;

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
{
    /**
     * private class DLLNode: implements a *generic* Doubly Linked List node.
     */
    private class DLLNode
    {
        public final T data; // this field should never be updated. It gets its
        // value once from the constructor DLLNode.
        public DLLNode next;
        public DLLNode prev;

        /**
         * Constructor
         * @param theData : data of type T, to be stored in the node
         * @param prevNode : the previous Node in the Doubly Linked List
         * @param nextNode : the next Node in the Doubly Linked List
         * @return DLLNode
         */
        public DLLNode(T theData)
        {
            data = theData;
        }
        public DLLNode(T theData, DLLNode prevNode, DLLNode nextNode)
        {
            this(theData);
            prev = prevNode;
            next = nextNode;
        }
    }

    // Fields head and tail point to the first and last nodes of the list.
    private DLLNode head, tail;

    /**
     * Constructor of an empty DLL
     * @return DoublyLinkedList
     */
    public DoublyLinkedList()
    {
        this.head = null;
        this.tail = null;
    }

    /**
     * Tests if the doubly linked list is empty
     * @return true if list is empty, and false otherwise
     *
     * Worst-case asymptotic running time cost: Theta(1)
     *
     * Justification:
     *  We only check if values are null, these are assumed to take Theta(1) running time
     *  The running time is then of Theta(1).
     */
    public boolean isEmpty()
    {
        return this.tail == null && this.head == null;
    }

    /**
     * Inserts an element in the doubly linked list
     * @param pos : The integer location at which the new data should be
     *      inserted in the list. We assume that the first position in the list
     *      is 0 (zero). If pos is less than 0 then add to the head of the list.
     *      If pos is greater or equal to the size of the list then add the
     *      element at the end of the list.
     * @param data : The new data of class T that needs to be added to the list
     * @return none
     *
     * Worst-case asymptotic running time cost: Theta(N)
     *
     * Justification:
     *  Let's assume that the size of the linked list is N
     *  we know from justifications above and underneath that the running times of isEmpty, enqueue is of Theta(1)
     *  We assumed java methods all take Theta(1) as well.
     *  In the worst case scenario, we iterate through the linked list and execute methods with running times of Theta(1)
     *  We then have Theta(1) + ( Theta(N) + Theta(1) ) = Theta(1) + Theta(N) = Theta(N)
     */
    public void insertBefore(int pos, T data)
    {
        // if list is empty of pos is 0 we just want to push
        if (isEmpty() || pos <= 0){
            this.push(data);
            return;
        }

        // find node at position pos
        DLLNode tmp = this.head;
        int i = 0;
        while (i != pos){
            // if there is no next node then enqueue
            if(tmp.next == null) {
                this.enqueue(data);
                return;
            }
            tmp = tmp.next;
            i++;
        }
        // insert new node & change next/prev of relevant nodes
        DLLNode newNode = new DLLNode(data);
        DLLNode before = tmp.prev;
        newNode.prev = before;
        newNode.next = tmp;

        tmp.prev = newNode;
        before.next = newNode;
    }

    /**
     * Returns the data stored at a particular position
     * @param pos : the position
     * @return the data at pos, if pos is within the bounds of the list, and null otherwise.
     *
     * Worst-case asymptotic running time cost: Theta(N)
     *
     * Justification:
     *  we know that isEmpty has a running time of Theta(1) (view justification above)
     *  It is also assumed that any other java method run in Theta(1)
     * Assuming that the linked list is of size N, we iterate through every node in the worst case
     * This means that the running time is then Theta(1) + ( Theta(N) * Theta(1) ) = Theta(1) + Theta(N) = Theta(N)
     */
    public T get(int pos)
    {
        if (this.isEmpty() || pos < 0) return null;
        if (pos == 0) return this.head.data;
        // find node at pos
        DLLNode tmp = this.head;
        int i = 0;
        while (i != pos){
            // return null is position does not have a node
            if(tmp.next == null) return null;
            tmp = tmp.next;
            i++;
        }
        return tmp.data;
    }

    /**
     * Deletes the element of the list at position pos.
     * First element in the list has position 0. If pos points outside the
     * elements of the list then no modification happens to the list.
     * @param pos : the position to delete in the list.
     * @return true : on successful deletion, false : list has not been modified.
     *
     * Worst-case asymptotic running time cost: Theta(N)
     *
     * Justification:
     *  This method uses java methods as well as methods we've seen (isEmpty, pop). These all have a running time of Theta(1)
     *  We assume that the size of the linked list is of N
     *  In the worst case we iterate through every single node which means the total running time is
     *  Theta(1) + Theta(N) = Theta(N)
     */
    public boolean deleteAt(int pos)
    {
        // no item to delete
        if (this.isEmpty() || pos < 0){
            return false;
        }

        // if index is 0 then pop item
        if (pos == 0) {
            this.pop();
            return true;
        }

        // find node at pos - 1
        DLLNode iter = head;
        for (int i = 0; iter != null && i<pos - 1; i++) iter = iter.next;

        // pos does not exist
        if (iter == null || iter.next == null) return false;

        // unlink nodes
        if(iter.next == this.tail){
            this.tail = iter;
        }
        iter.next = iter.next.next;
        return true;
    }

    /**
     * Reverses the list.
     * If the list contains "A", "B", "C", "D" before the method is called
     * Then it should contain "D", "C", "B", "A" after it returns.
     *
     * Worst-case asymptotic running time cost: Theta(N)
     *
     * Justification:
     *  This methods uses java methods to assign values from a Doubly Linked List to a new one in reverse order
     *  We assume these methods all take Theta(1)
     *  Lets assume the size of the linked list to be of N
     *  We've seen in the methods underneath that the push and pop methods both have a running time of Theta(1)
     *  We then execute N times Theta(1) + Theta(1)
     *  the total running time is then N * (Theta(1) + Theta(1)) = Theta(N)
     */
    public void reverse () {
        // create new linked list
        DoublyLinkedList<T> tmp = new DoublyLinkedList<>();

        // pop all elements from current & push to new (reverses the order)
        while (head != null){
            tmp.push(this.pop());
        }

        // update head and tail
        this.head = tmp.head;
        this.tail = tmp.tail;
    }

    /**
     * Removes all duplicate elements from the list.
     * The method should remove the _least_number_ of elements to make all elements uniqueue.
     * If the list contains "A", "B", "C", "B", "D", "A" before the method is called
     * Then it should contain "A", "B", "C", "D" after it returns.
     * The relative order of elements in the resulting list should be the same as the starting list.
     *
     * Worst-case asymptotic running time cost: Theta(N * M)
     *
     * Justification:
     *  We know from above that the method isEmpty has a running time of Theta(1)
     *  We assume that all java methods take Theta(1).
     *  Thus, any operations inside the first for loop will take Theta(1) + Theta(running time for the second for loop) * n
     *  Assuming the size of the linked list keeps growing as the method goes, we will refer to its size as M
     *  We also assume the size of the linked list to be N. It is clear that M <= N.
     *  The total running time is then N * (Theta(1) + Theta(M)) + Theta(1) = N * Theta(M) = Theta(N * M)
     */
    public void makeUniqueue()
    {
        if (this.isEmpty()) return;

        // list containing elements we've already seen in the actual list
        DoublyLinkedList<T> list = new DoublyLinkedList<>();
        int index = 0;

        // loop through current linked list
        for (DLLNode current = head; current != null; current = current.next){
            boolean inList = false;

            // look for element in list of elements we've already seen in the linked list
            for (DLLNode iter = list.head; iter != null && !inList; iter = iter.next){
                if(current.data == iter.data){
                    inList = true;
                }
            }

            // remove node or add element to list of elements
            if (!inList) {
                list.push(current.data);
            } else {
                this.deleteAt(index);
                index--;
            }
            index++;
        }
    }

    /*----------------------- STACK API
     * If only the push and pop methods are called the data structure should behave like a stack.
     */

    /**
     * This method adds an element to the data structure.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @param item : the item to push on the stack
     *
     * Worst-case asymptotic running time cost: Theta(1)
     *
     * Justification:
     *  This method creates and object and sets/returns some object properties.
     *  All of these are assumed to have a running time of Theta(1)
     *  As a result, the total running time for this method is of Theta(1)
     */
    public void push(T item)
    {
        DLLNode newNode = new DLLNode(item, null, this.head);
        if (this.head != null) this.head.prev = newNode;
        if (this.tail == null) this.tail = newNode;
        this.head = newNode;
    }

    /**
     * This method returns and removes the element that was most recently added by the push method.
     * @return the last item inserted with a push; or null when the list is empty.
     *
     * Worst-case asymptotic running time cost: Theta(1)
     *
     * Justification:
     *  This method checks and sets object attributes. We assume these all take Theta(1)
     *  The total running time for this function is then Theta(1) + Theta(isEmpty)
     *  We've seen above that the method isEmpty's running time is of Theta(1)
     *  The total running time is then Theta(1)
     */
    public T pop()
    {
        if(this.isEmpty()){
            return null;
        }
        DLLNode tmp = this.head;
        if (this.head == this.tail){
            this.head = null;
            this.tail = null;
        } else {
            this.head = this.head.next;
            this.head.prev = null;
        }
        return tmp.data;
    }

    /*----------------------- QUEUE API
     * If only the enqueue and dequeue methods are called the data structure should behave like a FIFO queue.
     */

    /**
     * This method adds an element to the data structure.
     * How exactly this will be represented in the Doubly Linked List is up to the programmer.
     * @param item : the item to be enqueued to the stack
     *
     * Worst-case asymptotic running time cost: Theta(1)
     *
     * Justification:
     * This methods creates a new object and checks/assigns data to them. We assume that these all take Theta(1)
     * This method's running time is the same no matter the input
     * As a result the total cost of this method is Theta(1)
     */
    public void enqueue(T item)
    {
        DLLNode newNode = new DLLNode(item, this.tail, null);
        if (this.tail != null) this.tail.next = newNode;
        if (this.head == null) this.head = newNode;
        this.tail = newNode;
    }

    /**
     * This method returns and removes the element that was least recently added by the enqueue method.
     * @return the earliest item inserted with an equeue; or null when the list is empty.
     *
     * Worst-case asymptotic running time cost: Theta(1)
     *
     * Justification:
     *  The running time of this method is the exact same as the pop() method. For the justification please go see the pop function.
     *
     *  Due to the way I implemented the queue method this only needs to pop an item
     */
    public T dequeue()
    {
        return this.pop();
    }


    /**
     * @return a string with the elements of the list as a comma-separated
     * list, from beginning to end
     *
     * Worst-case asymptotic running time cost:   Theta(n)
     *
     * Justification:
     *  We know from the Java documentation that StringBuilder's append() method runs in Theta(1) asymptotic time.
     *  We assume all other method calls here (e.g., the iterator methods above, and the toString method) will execute in Theta(1) time.
     *  Thus, every one iteration of the for-loop will have cost Theta(1).
     *  Suppose the doubly-linked list has 'n' elements.
     *  The for-loop will always iterate over all n elements of the list, and therefore the total cost of this method will be n*Theta(1) = Theta(n).
     */
    public String toString()
    {
        StringBuilder s = new StringBuilder();
        boolean isFirst = true;

        // iterate over the list, starting from the head
        for (DLLNode iter = head; iter != null; iter = iter.next)
        {
            if (!isFirst)
            {
                s.append(",");
            } else {
                isFirst = false;
            }
            s.append(iter.data.toString());
        }

        return s.toString();
    }
}
