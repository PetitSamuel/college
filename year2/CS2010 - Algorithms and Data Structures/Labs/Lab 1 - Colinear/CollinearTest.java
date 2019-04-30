import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import java.util.Arrays;
import static org.junit.Assert.*;

//-------------------------------------------------------------------------
/**
 *  Test class for Collinear.java
 *
 *  @author
 *  @version 18/09/18 12:21:26
 */
@RunWith(JUnit4.class)
public class CollinearTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new Collinear();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
        int expectedResult = 0;

        assertEquals("countCollinear failed with 3 empty arrays",       expectedResult, Collinear.countCollinear(new int[0], new int[0], new int[0]));
        assertEquals("countCollinearFast failed with 3 empty arrays", expectedResult, Collinear.countCollinearFast(new int[0], new int[0], new int[0]));
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleFalse()
    {
        int[] a3 = { 15 };
        int[] a2 = { 5 };
        int[] a1 = { 10 };

        int expectedResult = 0;

        assertEquals("countCollinear({10}, {5}, {15})",       expectedResult, Collinear.countCollinear(a1, a2, a3) );
        assertEquals("countCollinearFast({10}, {5}, {15})", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleTrue()
    {
        int[] a3 = { 15, 5 };       int[] a2 = { 5 };       int[] a1 = { 10, 15, 5 };

        int expectedResult = 1;

        assertEquals("countCollinear(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")",     expectedResult, Collinear.countCollinear(a1, a2, a3));
        assertEquals("countCollinearFast(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")", expectedResult, Collinear.countCollinearFast(a1, a2, a3));
    }


    /**
     * Test Count collinear brute and fast returns the expected value
     * Tests that if statements work as expected
     */
    @Test
    public void testcountCollinear()
    {
        int[] a3 = { 0, 5, 10 };
        int[] a2 = { 0, 1, 10 };
        int[] a1 = { 0, 7, 5 };
        int expectedResult = 2;
        assertEquals("Count collinear brute force", 2, Collinear.countCollinear(a1, a2, a3) );
        assertEquals("Count collinear fast", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );

        a3 = new int[] { 0 };
        a2 = new int[] { 0 };
        a1 = new int[] { 1 };
        expectedResult = 0;
        assertEquals("Test Count collinear if statement works as expected", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );
        assertEquals("Test Count collinear if statement works as expected", expectedResult, Collinear.countCollinear(a1, a2, a3) );

        a3 = new int[] { 3 };
        a2 = new int[] { 1 };
        a1 = new int[] { 1 };
        expectedResult = 1;
        assertEquals("Test Count collinear if statement works as expected", expectedResult, Collinear.countCollinear(a1, a2, a3) );
        assertEquals("Test Count collinear if statement works as expected", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );
    }


    /**
     * Test that sort returns the expected value
     */
    @Test
    public void testSort()
    {
        int[] unsorted = { 5, 7, 0, 10 };
        int[] sorted = {0, 5, 7, 10};
        Collinear.sort(unsorted);
        assertArrayEquals(sorted, unsorted);
    }


    /**
     * Test Count collinear brute and fast returns the expected value
     * Tests that if statements work as expected
     */
    @Test
    public void testBinarySearch()
    {
        int[] sorted = {0, 5, 7, 10};
        assertTrue(Collinear.binarySearch(sorted, 0));
        assertFalse(Collinear.binarySearch(sorted, 50));
        assertTrue(Collinear.binarySearch(sorted, 10));
    }

}



