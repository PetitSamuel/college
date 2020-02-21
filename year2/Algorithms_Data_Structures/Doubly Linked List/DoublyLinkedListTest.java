import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//-------------------------------------------------------------------------
/**
 *  Test class for Doubly Linked List
 *
 *  @author
 *  @version 13/10/16 18:15
 */
@RunWith(JUnit4.class)
public class DoublyLinkedListTest {
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new DoublyLinkedList<Integer>();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------

    @Test
    public void testEmptyWorks () {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        assertTrue(myStringList.isEmpty());
        myStringList.push(1);
        assertFalse(myStringList.isEmpty());
        myStringList.pop();
        assertTrue(myStringList.isEmpty());
    }

    @Test
    public void testPushAndPop() {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        myStringList.push(1);
        myStringList.push(5);
        assertEquals("5,1", myStringList.toString());
        int val = myStringList.pop();
        assertEquals(5, val);
    }

    @Test
    public void testGet () {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        myStringList.push(1);
        myStringList.push(5);
        int val = myStringList.get(0);
        assertEquals(5, val);
        val = myStringList.get(1);
        assertEquals(1, val);
        assertNull(myStringList.get(-10));
        assertNull(myStringList.get(10));
    }

    @Test
    public void testQueue () {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        assertNull(myStringList.dequeue());
        myStringList.enqueue(50);
        myStringList.enqueue(101);
        assertEquals("50,101", myStringList.toString());
        int val = myStringList.dequeue();
        assertEquals(50, val);
        val = myStringList.dequeue();
        assertEquals(101, val);
    }

    @Test
    public void testReverse () {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        myStringList.insertBefore(1, 101);
        myStringList.push(1);
        myStringList.push(5);
        assertEquals("5,1,101", myStringList.toString());
        myStringList.reverse();
        assertEquals("101,1,5", myStringList.toString());
        myStringList.pop();
        assertEquals("1,5", myStringList.toString());
        myStringList.reverse();
        assertEquals("5,1", myStringList.toString());
        myStringList.pop();
        assertEquals("1", myStringList.toString());
    }

    @Test
    public void testDeleteAt () {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        assertFalse(myStringList.deleteAt(50));
        myStringList.push(1);
        myStringList.push(5);
        myStringList.push(10);
        myStringList.push(11);
        myStringList.push(12);
        assertEquals("12,11,10,5,1", myStringList.toString());
        myStringList.deleteAt(3);
        assertEquals("12,11,10,1", myStringList.toString());
        myStringList.deleteAt(3);
        assertEquals("12,11,10", myStringList.toString());
        myStringList.deleteAt(1);
        myStringList.deleteAt(0);
        assertFalse(myStringList.deleteAt(100));
        assertEquals("10", myStringList.toString());

    }
    @Test
    public void testMakeUnique () {
        DoublyLinkedList<Integer> myStringList = new DoublyLinkedList<>();
        myStringList.push(11);
        myStringList.push(5);
        myStringList.push(10);
        myStringList.push(0);
        myStringList.push(11);
        myStringList.push(12);
        myStringList.push(0);
        myStringList.makeUniqueue();
        assertEquals("0,12,11,10,5", myStringList.toString());
    }

    /**
     * Check if the insertBefore works
     */
    @Test
    public void testInsertBefore()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        testDLL.insertBefore(1,2);
        testDLL.insertBefore(2,3);

        testDLL.insertBefore(0,4);
        assertEquals( "Checking insertBefore to a list containing 3 elements at position 0", "4,1,2,3", testDLL.toString() );
        testDLL.insertBefore(1,5);
        assertEquals( "Checking insertBefore to a list containing 4 elements at position 1", "4,5,1,2,3", testDLL.toString() );
        testDLL.insertBefore(2,6);
        assertEquals( "Checking insertBefore to a list containing 5 elements at position 2", "4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(-1,7);
        assertEquals( "Checking insertBefore to a list containing 6 elements at position -1 - expected the element at the head of the list", "7,4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(7,8);
        assertEquals( "Checking insertBefore to a list containing 7 elemenets at position 8 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8", testDLL.toString() );
        testDLL.insertBefore(700,9);
        assertEquals( "Checking insertBefore to a list containing 8 elements at position 700 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8,9", testDLL.toString() );

        // test empty list
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        assertEquals( "Checking insertBefore to an empty list at position 0 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(10,1);
        assertEquals( "Checking insertBefore to an empty list at position 10 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(-10,1);
        assertEquals( "Checking insertBefore to an empty list at position -10 - expected the element at the head of the list", "1", testDLL.toString() );
    }

}


